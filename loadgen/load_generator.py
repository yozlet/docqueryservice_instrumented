#!/usr/bin/env python3
"""
Document Query Service Continuous Load Generator
A Playwright-based continuous load testing tool with OpenTelemetry instrumentation
"""

import asyncio
import json
import random
import time
import signal
import os
from datetime import datetime, timedelta
from pathlib import Path
from typing import Dict, List, Optional
import click
from faker import Faker
from playwright.async_api import async_playwright, Browser, BrowserContext, Page
from colorama import init, Fore, Style
from dotenv import load_dotenv

# OpenTelemetry imports
from opentelemetry import trace, metrics
from opentelemetry.exporter.otlp.proto.grpc.trace_exporter import OTLPSpanExporter
from opentelemetry.exporter.otlp.proto.grpc.metric_exporter import OTLPMetricExporter
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import BatchSpanProcessor
from opentelemetry.sdk.metrics import MeterProvider
from opentelemetry.sdk.metrics.export import PeriodicExportingMetricReader
from opentelemetry.sdk.resources import Resource

# Initialize colorama for cross-platform colored output
init(autoreset=True)

fake = Faker()

class ContinuousLoadGenerator:
    def __init__(self, hostname: str, requests_per_minute: int, simultaneous_sessions: int, otlp_endpoint: str = None):
        self.hostname = hostname
        self.requests_per_minute = requests_per_minute
        self.simultaneous_sessions = simultaneous_sessions
        self.running = False
        self.browser: Optional[Browser] = None

        # Load environment variables
        load_dotenv()

        # Configure Honeycomb/OTLP settings
        self.honeycomb_api_key = os.getenv('HONEYCOMB_API_KEY')
        self.honeycomb_dataset = os.getenv('HONEYCOMB_DATASET', 'docquery-loadgen')

        if self.honeycomb_api_key:
            self.otlp_endpoint = 'https://api.honeycomb.io:443'
            self.otlp_headers = f"x-honeycomb-team={self.honeycomb_api_key}"
            print(f"{Fore.GREEN}🍯 Using Honeycomb.io with dataset: {self.honeycomb_dataset}")
        else:
            self.otlp_endpoint = otlp_endpoint or 'http://localhost:4317'
            self.otlp_headers = None
            print(f"{Fore.YELLOW}⚠️  No HONEYCOMB_API_KEY found, using OTLP endpoint: {self.otlp_endpoint}")

        # Statistics
        self.stats = {
            'total_requests': 0,
            'successful_requests': 0,
            'failed_requests': 0,
            'start_time': None,
            'current_sessions': 0
        }

        # Setup OpenTelemetry
        self.setup_telemetry()

        # Get tracer and meter
        self.tracer = trace.get_tracer("loadgen")
        self.meter = metrics.get_meter("loadgen")

        # Create metrics
        self.request_counter = self.meter.create_counter(
            "loadgen_requests_total",
            description="Total number of requests made"
        )
        self.success_counter = self.meter.create_counter(
            "loadgen_requests_successful",
            description="Number of successful requests"
        )
        self.error_counter = self.meter.create_counter(
            "loadgen_requests_failed",
            description="Number of failed requests"
        )
        self.response_time_histogram = self.meter.create_histogram(
            "loadgen_response_time_seconds",
            description="Response time in seconds"
        )
        self.active_sessions_gauge = self.meter.create_up_down_counter(
            "loadgen_active_sessions",
            description="Number of active sessions"
        )

    def setup_telemetry(self):
        """Initialize OpenTelemetry with OTLP export"""
        # Create resource with Honeycomb dataset if available
        resource_attrs = {
            "service.name": "docquery-loadgen",
            "service.version": "1.0.0",
            "service.instance.id": f"loadgen-{int(time.time())}"
        }

        if self.honeycomb_dataset:
            resource_attrs["honeycomb.dataset"] = self.honeycomb_dataset

        resource = Resource.create(resource_attrs)

        # Setup tracing
        trace_exporter_kwargs = {"endpoint": self.otlp_endpoint}
        if self.otlp_headers:
            trace_exporter_kwargs["headers"] = (("x-honeycomb-team", self.honeycomb_api_key),)
        else:
            trace_exporter_kwargs["insecure"] = True

        trace_exporter = OTLPSpanExporter(**trace_exporter_kwargs)
        span_processor = BatchSpanProcessor(trace_exporter)
        trace.set_tracer_provider(TracerProvider(resource=resource))
        trace.get_tracer_provider().add_span_processor(span_processor)

        # Setup metrics
        metric_exporter_kwargs = {"endpoint": self.otlp_endpoint}
        if self.otlp_headers:
            metric_exporter_kwargs["headers"] = (("x-honeycomb-team", self.honeycomb_api_key),)
        else:
            metric_exporter_kwargs["insecure"] = True

        metric_exporter = OTLPMetricExporter(**metric_exporter_kwargs)
        metric_reader = PeriodicExportingMetricReader(metric_exporter, export_interval_millis=5000)
        metrics.set_meter_provider(MeterProvider(resource=resource, metric_readers=[metric_reader]))

        # Note: AsyncIO instrumentation removed due to compatibility issues

        endpoint_display = "Honeycomb.io" if self.honeycomb_api_key else self.otlp_endpoint
        print(f"{Fore.GREEN}✓ OpenTelemetry initialized - sending to {endpoint_display}")

    async def setup_browser(self) -> Browser:
        """Initialize and configure browser instance"""
        playwright = await async_playwright().start()
        self.browser = await playwright.chromium.launch(
            headless=True,
            args=['--no-sandbox', '--disable-dev-shm-usage', '--disable-web-security']
        )
        return self.browser

    async def create_context(self) -> BrowserContext:
        """Create browser context with realistic settings"""
        context = await self.browser.new_context(
            viewport={'width': 1920, 'height': 1080},
            user_agent='LoadGen/1.0 (Playwright Browser Automation)'
        )
        return context

    async def perform_search_request(self, session_id: int) -> Dict:
        """Execute a single search request"""
        start_time = time.time()
        result = {'success': False, 'error': None, 'response_time': 0, 'session_id': session_id}

        with self.tracer.start_as_current_span("search_request") as span:
            span.set_attribute("session.id", session_id)
            span.set_attribute("target.hostname", self.hostname)

            context = None
            page = None

            try:
                # Create new browser context and page for each request
                context = await self.create_context()
                page = await context.new_page()

                # Navigate to the search app
                target_url = f"http://{self.hostname}"
                span.set_attribute("http.url", target_url)

                await page.goto(target_url, wait_until='networkidle', timeout=15000)

                # Wait for the search interface to load (MUI TextField)
                await page.wait_for_selector('input[type="text"]', timeout=10000)

                # Generate realistic search term
                search_term = self.generate_search_term()
                span.set_attribute("search.term", search_term)

                # Perform search - find the "Search Text" TextField input
                search_input = page.locator('input[type="text"]').first
                await search_input.fill(search_term)

                # Click the Search button instead of pressing Enter
                search_button = page.locator('button:has-text("Search")')
                await search_button.click()

                # Wait for results with timeout
                await page.wait_for_load_state('networkidle', timeout=15000)

                # Optional: brief interaction simulation
                await asyncio.sleep(random.uniform(0.5, 2.0))

                result['success'] = True
                span.set_attribute("request.success", True)

            except Exception as e:
                result['error'] = str(e)
                span.set_attribute("request.success", False)
                span.set_attribute("error.message", str(e))
                span.record_exception(e)

            finally:
                if page:
                    await page.close()
                if context:
                    await context.close()

                result['response_time'] = time.time() - start_time
                span.set_attribute("response.time", result['response_time'])

        return result

    def generate_search_term(self) -> str:
        """Generate realistic search terms for document queries"""
        search_patterns = [
            # World Bank document topics
            ['poverty', 'reduction', 'strategy'],
            ['economic', 'development', 'report'],
            ['infrastructure', 'investment', 'analysis'],
            ['education', 'policy', 'framework'],
            ['health', 'sector', 'assessment'],
            ['climate', 'change', 'adaptation'],
            ['governance', 'institutional', 'reform'],
            ['agriculture', 'rural', 'development'],
            ['trade', 'competitiveness', 'study'],
            ['financial', 'sector', 'review'],
            ['energy', 'sector', 'strategy'],
            ['water', 'resources', 'management'],
            ['urban', 'development', 'planning'],
            ['social', 'protection', 'systems']
        ]

        # Choose random pattern and select 1-2 words
        pattern = random.choice(search_patterns)
        num_words = random.randint(1, 2)
        return ' '.join(random.sample(pattern, num_words))

    async def session_worker(self, session_id: int):
        """Worker that runs continuously for a single session"""
        self.active_sessions_gauge.add(1, {"session_id": str(session_id)})

        print(f"{Fore.CYAN}🚀 Session {session_id} started")

        # Calculate delay between requests for this session
        delay_between_requests = (60.0 * self.simultaneous_sessions) / self.requests_per_minute

        try:
            while self.running:
                request_start = time.time()

                # Perform search request
                result = await self.perform_search_request(session_id)

                # Update statistics and metrics
                self.stats['total_requests'] += 1
                self.request_counter.add(1, {"session_id": str(session_id)})

                if result['success']:
                    self.stats['successful_requests'] += 1
                    self.success_counter.add(1, {"session_id": str(session_id)})
                    status_icon = f"{Fore.GREEN}✓"
                else:
                    self.stats['failed_requests'] += 1
                    self.error_counter.add(1, {"session_id": str(session_id), "error": str(result['error'])[:50]})
                    status_icon = f"{Fore.RED}✗"

                self.response_time_histogram.record(result['response_time'], {"session_id": str(session_id)})

                # Print activity
                timestamp = datetime.now().strftime("%H:%M:%S")
                print(f"{status_icon} {timestamp} Session-{session_id:02d}: "
                      f"Response: {result['response_time']:.2f}s | "
                      f"Total: {self.stats['total_requests']} | "
                      f"Success: {self.stats['successful_requests']}/{self.stats['total_requests']} "
                      f"({(self.stats['successful_requests']/max(self.stats['total_requests'],1)*100):.1f}%)")

                # Wait until it's time for the next request
                elapsed = time.time() - request_start
                sleep_time = max(0, delay_between_requests - elapsed)
                if sleep_time > 0:
                    await asyncio.sleep(sleep_time)

        except asyncio.CancelledError:
            pass
        finally:
            self.active_sessions_gauge.add(-1, {"session_id": str(session_id)})
            print(f"{Fore.YELLOW}🛑 Session {session_id} stopped")

    async def print_stats_periodically(self):
        """Print periodic statistics summary"""
        while self.running:
            await asyncio.sleep(30)  # Print stats every 30 seconds

            if self.stats['start_time']:
                elapsed = time.time() - self.stats['start_time']
                rps = self.stats['total_requests'] / elapsed if elapsed > 0 else 0

                print(f"\n{Fore.MAGENTA}{'='*60}")
                print(f"{Fore.MAGENTA}📊 STATS - Runtime: {elapsed:.0f}s | "
                      f"RPS: {rps:.1f} | "
                      f"Success Rate: {(self.stats['successful_requests']/max(self.stats['total_requests'],1)*100):.1f}%")
                print(f"{Fore.MAGENTA}{'='*60}\n")

    async def test_target_connectivity(self) -> bool:
        """Test if the target application is accessible before starting load test"""
        print(f"{Fore.CYAN}🔍 Testing connectivity to {self.hostname}...")

        # Setup browser for connectivity test
        test_browser = await self.setup_browser()
        context = None
        page = None

        try:
            context = await self.create_context()
            page = await context.new_page()

            target_url = f"http://{self.hostname}"
            print(f"   Attempting to load: {target_url}")

            # Try to navigate with a reasonable timeout
            await page.goto(target_url, wait_until='domcontentloaded', timeout=15000)

            # Check if we got a valid response
            if page.url.startswith('http'):
                print(f"{Fore.GREEN}✅ Successfully loaded front page")
                print(f"   Final URL: {page.url}")
                print(f"   Title: {await page.title()}")

                # Try to find search interface (MUI TextField)
                try:
                    search_element = await page.wait_for_selector(
                        'input[label="Search Text"], input[aria-label*="Search"], input[placeholder*="search"], input[type="text"]',
                        timeout=5000
                    )
                    if search_element:
                        print(f"{Fore.GREEN}✅ Search interface found")
                        return True
                    else:
                        print(f"{Fore.YELLOW}⚠️  Front page loaded but no search interface found")
                        print(f"   This may cause load test failures")
                        return True  # Still allow test to proceed

                except Exception:
                    print(f"{Fore.YELLOW}⚠️  Search interface not found within 5 seconds")
                    print(f"   This may cause load test failures, but continuing...")
                    return True  # Still allow test to proceed

            else:
                print(f"{Fore.RED}❌ Invalid response URL: {page.url}")
                return False

        except Exception as e:
            print(f"{Fore.RED}❌ CONNECTIVITY TEST FAILED")
            print(f"{Fore.RED}   Error: {str(e)}")

            # Provide specific error guidance
            if "net::ERR_CONNECTION_REFUSED" in str(e):
                print(f"{Fore.RED}   → Connection refused - is the application running?")
                print(f"{Fore.RED}   → Check that service is available at {self.hostname}")
            elif "net::ERR_NAME_NOT_RESOLVED" in str(e):
                print(f"{Fore.RED}   → DNS resolution failed - check hostname")
                print(f"{Fore.RED}   → Verify {self.hostname} is correct")
            elif "Timeout" in str(e) or "timeout" in str(e):
                print(f"{Fore.RED}   → Page load timeout - application may be slow or unresponsive")
                print(f"{Fore.RED}   → Check application performance and network connectivity")
            else:
                print(f"{Fore.RED}   → Unexpected error - see details above")

            return False

        finally:
            if page:
                await page.close()
            if context:
                await context.close()
            if test_browser:
                await test_browser.close()

    async def run_continuous_load(self):
        """Run continuous load test"""
        print(f"{Fore.GREEN}🎯 Preparing continuous load generation:")
        print(f"   Target: {self.hostname}")
        print(f"   Rate: {self.requests_per_minute} requests/minute")
        print(f"   Sessions: {self.simultaneous_sessions}")
        if self.honeycomb_api_key:
            print(f"   Honeycomb: {self.honeycomb_dataset} dataset")
        else:
            print(f"   OTLP: {self.otlp_endpoint}")
        print(f"   Expected RPS: {self.requests_per_minute/60:.1f}")
        print()

        # Test connectivity first - fail fast if target is unreachable
        if not await self.test_target_connectivity():
            print(f"\n{Fore.RED}🚫 ABORTING: Cannot reach target application")
            print(f"{Fore.RED}   Fix the connectivity issues above before running load tests")
            return

        # If we get here, target is reachable
        self.running = True
        self.stats['start_time'] = time.time()

        print(f"\n{Fore.GREEN}🚀 Starting load generation...")

        # Setup browser for load testing
        await self.setup_browser()

        try:
            # Start session workers
            tasks = []
            for session_id in range(self.simultaneous_sessions):
                task = asyncio.create_task(self.session_worker(session_id))
                tasks.append(task)

            # Start stats printer
            stats_task = asyncio.create_task(self.print_stats_periodically())
            tasks.append(stats_task)

            # Wait for all tasks
            await asyncio.gather(*tasks)

        except asyncio.CancelledError:
            print(f"{Fore.YELLOW}\n🛑 Shutting down load generator...")
        finally:
            if self.browser:
                await self.browser.close()

    def stop(self):
        """Stop the load generator"""
        self.running = False


# Global load generator instance for signal handling
load_gen = None

def signal_handler(signum, frame):
    """Handle shutdown signals gracefully"""
    if load_gen:
        print(f"\n{Fore.YELLOW}🛑 Received shutdown signal, stopping load generator...")
        load_gen.stop()

@click.command()
@click.option('--hostname', '-h', required=True, help='Target hostname (e.g., localhost:5173)')
@click.option('--rpm', '--requests-per-minute', type=int, default=60, help='Target requests per minute (default: 60)')
@click.option('--sessions', '-s', type=int, default=5, help='Number of simultaneous sessions (default: 5)')
@click.option('--otlp-endpoint', default='http://localhost:4317', help='OTLP endpoint (default: http://localhost:4317)')
def main(hostname, rpm, sessions, otlp_endpoint):
    """
    Document Query Service Continuous Load Generator

    Generates continuous load against the search application with OpenTelemetry instrumentation.

    Examples:
      loadgen.py -h localhost:5173 --rpm 120 -s 10
      loadgen.py -h myapp.com --rpm 300 --sessions 20 --otlp-endpoint http://otel-collector:4317
    """
    global load_gen

    # Setup signal handlers
    signal.signal(signal.SIGINT, signal_handler)
    signal.signal(signal.SIGTERM, signal_handler)

    # Create and run load generator
    load_gen = ContinuousLoadGenerator(hostname, rpm, sessions, otlp_endpoint)

    try:
        asyncio.run(load_gen.run_continuous_load())
    except KeyboardInterrupt:
        print(f"\n{Fore.GREEN}✓ Load generator stopped cleanly")


if __name__ == '__main__':
    main()