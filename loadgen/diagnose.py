#!/usr/bin/env python3
"""
Diagnostic script to check load generator dependencies and configuration
"""

import sys
import subprocess
from pathlib import Path

def check_python_version():
    print(f"Python version: {sys.version}")
    if sys.version_info < (3, 7):
        print("❌ Python 3.7+ required")
        return False
    print("✅ Python version OK")
    return True

def check_virtual_env():
    if hasattr(sys, 'real_prefix') or (hasattr(sys, 'base_prefix') and sys.base_prefix != sys.prefix):
        print("✅ Virtual environment activated")
        return True
    else:
        print("⚠️  Virtual environment not detected")
        return False

def check_dependencies():
    print("\n🔍 Checking dependencies...")

    dependencies = [
        'playwright',
        'click',
        'colorama',
        'faker',
        'opentelemetry-api',
        'opentelemetry-sdk',
        'opentelemetry-exporter-otlp-proto-grpc',
        'opentelemetry-instrumentation-asyncio',
        'python-dotenv'
    ]

    all_ok = True
    for dep in dependencies:
        try:
            __import__(dep.replace('-', '_'))
            print(f"✅ {dep}")
        except ImportError as e:
            print(f"❌ {dep} - {e}")
            all_ok = False

    return all_ok

def check_playwright_browsers():
    print("\n🌐 Checking Playwright browsers...")
    try:
        result = subprocess.run(['playwright', 'install', '--dry-run'],
                              capture_output=True, text=True, timeout=30)
        if result.returncode == 0:
            print("✅ Playwright browsers check passed")
            return True
        else:
            print(f"⚠️  Playwright browsers issue: {result.stderr}")
            return False
    except Exception as e:
        print(f"❌ Playwright browser check failed: {e}")
        return False

def check_env_file():
    print("\n📄 Checking .env file...")
    env_file = Path('.env')
    if env_file.exists():
        print("✅ .env file found")
        with open(env_file) as f:
            content = f.read()
            if 'HONEYCOMB_API_KEY' in content:
                print("✅ HONEYCOMB_API_KEY configured")
            else:
                print("⚠️  No HONEYCOMB_API_KEY in .env")
    else:
        print("⚠️  No .env file found (will use default OTLP endpoint)")

def test_import():
    print("\n🧪 Testing load generator import...")
    try:
        from load_generator import ContinuousLoadGenerator
        print("✅ Load generator imports successfully")
        return True
    except ImportError as e:
        print(f"❌ Import failed: {e}")
        return False
    except Exception as e:
        print(f"❌ Unexpected error: {e}")
        return False

def main():
    print("🔍 Load Generator Diagnostic Tool")
    print("=" * 40)

    checks = [
        check_python_version(),
        check_virtual_env(),
        check_dependencies(),
        check_playwright_browsers(),
        test_import()
    ]

    check_env_file()

    print("\n" + "=" * 40)
    if all(checks):
        print("✅ All checks passed! Load generator should work.")
    else:
        print("❌ Some issues found. Please fix the above errors.")
        print("\n🔧 Suggested fixes:")
        print("1. Ensure virtual environment is activated: source venv/bin/activate")
        print("2. Reinstall dependencies: pip install -r requirements.txt")
        print("3. Install Playwright browsers: playwright install chromium")
        print("4. Check Python version is 3.7+")

if __name__ == '__main__':
    main()