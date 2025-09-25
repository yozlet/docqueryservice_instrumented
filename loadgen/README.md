# Document Query Service Load Generator

A continuous load testing tool using Playwright to simulate realistic browser traffic against the React search application, with comprehensive OpenTelemetry instrumentation.

## Features

- **Continuous Operation**: Runs indefinitely with configurable request rates
- **Realistic Browser Simulation**: Uses Playwright to drive real Chromium browsers
- **OpenTelemetry Integration**: Full observability with traces, metrics, and logs
- **Configurable Load Patterns**: Control request rate and concurrent sessions
- **Real-time Monitoring**: Live activity logging and periodic statistics
- **Graceful Shutdown**: Handles SIGINT/SIGTERM for clean termination

## Quick Start

1. **Setup the environment:**
   ```bash
   cd loadgen
   ./setup.sh
   ```

2. **Configure Honeycomb.io (recommended):**
   ```bash
   cp .env.example .env
   # Edit .env and add your HONEYCOMB_API_KEY
   ```

3. **Activate the virtual environment:**
   ```bash
   source venv/bin/activate
   ```

4. **Run basic load test:**
   ```bash
   python load_generator.py -h localhost:5173 --rpm 60 --sessions 5
   ```

## Usage

### Basic Command
```bash
python load_generator.py --hostname TARGET --rpm RATE --sessions COUNT [--otlp-endpoint URL]
```

### Parameters

- `--hostname, -h`: **Required** - Target hostname and port (e.g., `localhost:5173`, `myapp.com`)
- `--rpm, --requests-per-minute`: Request rate per minute (default: 60)
- `--sessions, -s`: Number of simultaneous browser sessions (default: 5)
- `--otlp-endpoint`: OpenTelemetry collector endpoint (default: `http://localhost:4317`)

### Examples

**Light load testing:**
```bash
python load_generator.py -h localhost:5173 --rpm 30 --sessions 3
```

**Moderate load:**
```bash
python load_generator.py -h localhost:5173 --rpm 120 --sessions 10
```

**High load with remote OTLP:**
```bash
python load_generator.py -h myapp.com --rpm 300 --sessions 20 --otlp-endpoint http://otel-collector:4317
```

**Production testing:**
```bash
python load_generator.py -h production.example.com --rpm 600 --sessions 50 --otlp-endpoint https://api.honeycomb.io:443
```

## How It Works

### Load Distribution
- Each session runs in parallel, maintaining its own browser context
- Requests are distributed evenly across sessions
- Each session waits between requests to maintain the target rate

### Search Simulation
The load generator simulates realistic document search behavior:

1. **Navigate** to the target application
2. **Wait** for the search interface to load
3. **Generate** realistic search terms based on World Bank document topics
4. **Execute** search by filling input and pressing Enter
5. **Wait** for results to load with network idle detection
6. **Simulate** brief user reading time
7. **Repeat** with appropriate delays

### Search Terms
Generates realistic queries using combinations of:
- `poverty reduction strategy`
- `economic development report`
- `infrastructure investment`
- `education policy framework`
- `climate change adaptation`
- And many more domain-specific terms

## OpenTelemetry Instrumentation

### Traces
Every search request creates a span with attributes:
- `session.id`: Session identifier
- `target.hostname`: Target application
- `http.url`: Full request URL
- `search.term`: Search query used
- `request.success`: Success/failure status
- `response.time`: Total response time
- `error.message`: Error details (if failed)

### Metrics
Comprehensive metrics collection:
- `loadgen_requests_total`: Total requests made
- `loadgen_requests_successful`: Successful requests
- `loadgen_requests_failed`: Failed requests
- `loadgen_response_time_seconds`: Response time histogram
- `loadgen_active_sessions`: Current active sessions

### Resource Attributes
- `service.name`: `docquery-loadgen`
- `service.version`: `1.0.0`
- `service.instance.id`: Unique instance identifier

## Real-time Output

The load generator provides continuous feedback:

```
🎯 Starting continuous load generation:
   Target: localhost:5173
   Rate: 120 requests/minute
   Sessions: 10
   OTLP: http://localhost:4317
   Expected RPS: 2.0

✓ OpenTelemetry initialized - sending to http://localhost:4317
🚀 Session 0 started
🚀 Session 1 started
...

✓ 14:32:15 Session-01: Response: 1.23s | Total: 45 | Success: 44/45 (97.8%)
✓ 14:32:16 Session-03: Response: 0.89s | Total: 46 | Success: 45/46 (97.8%)
✗ 14:32:17 Session-02: Response: 2.45s | Total: 47 | Success: 45/47 (95.7%)

📊 ============================================================
📊 STATS - Runtime: 120s | RPS: 2.1 | Success Rate: 95.7%
📊 ============================================================
```

## Honeycomb.io Integration

The load generator automatically detects Honeycomb configuration from a `.env` file:

### Setup Honeycomb

1. **Copy the example environment file:**
   ```bash
   cp .env.example .env
   ```

2. **Edit `.env` with your Honeycomb settings:**
   ```bash
   # Required: Get your API key from https://ui.honeycomb.io/account
   HONEYCOMB_API_KEY=your_actual_api_key_here

   # Optional: Custom dataset name (defaults to 'docquery-loadgen')
   HONEYCOMB_DATASET=my-loadgen-dataset
   ```

3. **Run the load generator (it will auto-detect Honeycomb config):**
   ```bash
   python load_generator.py -h localhost:5173 --rpm 60 --sessions 5
   ```

### Expected Output with Honeycomb
```
🍯 Using Honeycomb.io with dataset: docquery-loadgen
✓ OpenTelemetry initialized - sending to Honeycomb.io
🎯 Starting continuous load generation:
   Target: localhost:5173
   Rate: 60 requests/minute
   Sessions: 5
   Honeycomb: docquery-loadgen dataset
   Expected RPS: 1.0
```

### Fallback to Custom OTLP
If no `HONEYCOMB_API_KEY` is found, the load generator falls back to:
- Command line `--otlp-endpoint` parameter
- Default: `http://localhost:4317`

## Troubleshooting

### Common Issues

**Import errors (ModuleNotFoundError):**
```bash
# Ensure virtual environment is activated
source venv/bin/activate

# Reinstall dependencies if needed
pip install -r requirements.txt
```

**AsyncIO instrumentation error:**
This has been fixed by removing the problematic `AsyncIOInstrumentor` import.

**Browser fails to start:**
```bash
# Reinstall Playwright browsers
playwright install chromium
```

**Connection refused:**
- Verify target application is running
- Check hostname and port
- Ensure no firewall blocking

**High error rate:**
- Reduce request rate (`--rpm`)
- Reduce concurrent sessions (`--sessions`)
- Check application logs for capacity issues

**OpenTelemetry not working:**
- Verify OTLP endpoint is accessible
- Check collector/Honeycomb configuration
- Ensure proper authentication headers

**Diagnostic tool:**
```bash
python diagnose.py
```

### Performance Tips

- **Start small**: Begin with low rates and increase gradually
- **Monitor target**: Watch application performance during load testing
- **Resource limits**: Each session uses ~50-100MB of memory
- **Network latency**: Higher latency requires fewer concurrent sessions

## Dependencies

- Python 3.7+
- Playwright (with Chromium browser)
- OpenTelemetry libraries
- Click (CLI framework)
- Faker (realistic data generation)

## Development

### Project Structure
```
loadgen/
├── load_generator.py    # Main load generator script
├── requirements.txt     # Python dependencies
├── setup.sh            # Setup script
├── README.md           # This file
└── venv/               # Virtual environment (after setup)
```

### Contributing
1. Ensure all dependencies are in `requirements.txt`
2. Follow Python PEP8 style guidelines
3. Add comprehensive error handling
4. Update OpenTelemetry attributes for new features
5. Test with different load patterns

## License

Part of the Document Query Service observability demo project.