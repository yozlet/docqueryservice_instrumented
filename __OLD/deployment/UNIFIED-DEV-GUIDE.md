# Unified Local Development Guide

## 🚀 Single Script Management

The **`dev.sh`** script provides unified management of your hybrid local development environment.

### 📋 **All Commands**

```bash
cd deployment

# Start services
./dev.sh start                # Start database only, show manual commands
./dev.sh start --auto         # Start all services automatically
./dev.sh start --auto --verbose  # Start all services (recommended - more reliable)

# Monitor services
./dev.sh status          # Check status of all services
./dev.sh logs            # Show database container logs

# Control services
./dev.sh stop            # Stop all services cleanly
./dev.sh restart         # Restart entire environment

# Get help
./dev.sh help            # Show detailed help and examples
```

### 🎯 **Recommended Workflow**

#### **Quick Start (Auto Mode)**
```bash
./dev.sh start --auto --verbose    # Recommended - most reliable
# OR
./dev.sh start --auto              # May have issues on some systems
```
This automatically starts:
1. ✅ Database container (Docker)
2. ✅ Backend API (shell process)
3. ✅ Frontend dev server (shell process)

**Note**: If `--auto` hangs, use `--verbose` flag for more reliable startup.

#### **Manual Control**
```bash
./dev.sh start          # Start database, show manual commands
./dev.sh status          # Check what's running
./dev.sh stop            # Clean shutdown of everything
```

### 📊 **Service Status Overview**

The `status` command shows a complete overview:

```bash
$ ./dev.sh status

Document Query Service - Development Status
============================================

  ✓ Database (Azure SQL Edge): Running (healthy)
  ✓ Backend (.NET API): Running (port 5001, PID: 12345)
  ✓ Frontend (React + Vite): Running (port 5173, PID: 67890)

Service URLs:
  Database:  localhost:1433 (user: sa, password: DevPassword123!)
  Backend:   http://localhost:5001 (API + Swagger UI)
  Frontend:  http://localhost:5173
```

### 🛑 **Clean Shutdown**

```bash
./dev.sh stop
```

This will:
- ✅ Stop frontend Vite processes
- ✅ Stop backend .NET processes
- ✅ Stop and remove database container
- ✅ Clean up log files and temporary files

### 🔧 **Advanced Options**

```bash
# Verbose output for debugging
./dev.sh start --verbose

# Quiet mode (minimal output)
./dev.sh stop --quiet

# Database logs (streaming)
./dev.sh logs
```

### 🌐 **Service Architecture**

| Service | Type | Port | URL | Purpose |
|---------|------|------|-----|---------|
| **Database** | Docker | 1433 | `localhost:1433` | Azure SQL Edge |
| **Backend** | Shell | 5001 | `http://localhost:5001` | .NET API + Swagger |
| **Frontend** | Shell | 5173+ | `http://localhost:5173` | React + Vite HMR |

### ⚙️ **Configuration**

All services use `local-dev.env` for configuration:

```bash
# Backend
ASPNETCORE_ENVIRONMENT=Development
LISTEN_HOST=localhost
LISTEN_PORT=5001
DB_SERVER=localhost
DB_DATABASE=DocQueryService

# Frontend
VITE_ENVIRONMENT=development
VITE_API_BASE_URL=http://localhost:5001/api/v3
```

### 🧪 **Testing Your Setup**

```bash
# 1. Start everything (use --verbose for reliability)
./dev.sh start --auto --verbose

# 2. Check status
./dev.sh status

# 3. Test endpoints
curl http://localhost:5001/health          # Backend health
curl http://localhost:5001/api/v3/wds      # API endpoint
curl http://localhost:5173/                # Frontend

# 4. Clean shutdown
./dev.sh stop
```

### 🚨 **Troubleshooting**

#### **Auto-Start Issues**
```bash
# If ./dev.sh start --auto hangs or fails:
./dev.sh start --auto --verbose    # Use verbose mode (more reliable)
./dev.sh start                     # Or use manual mode instead
```

#### **Port Conflicts**
```bash
./dev.sh status              # Check what's running
lsof -i :5001               # See what's using port 5001
./dev.sh stop               # Clean shutdown
```

#### **Service Won't Start**
```bash
./dev.sh start --verbose    # Detailed startup logging
./dev.sh logs               # Check database container logs
```

#### **Database Issues**
```bash
docker ps                   # Check container status
docker logs docquery-database-dev  # Direct container logs
./dev.sh restart           # Fresh restart
```

### 💡 **Tips**

1. **Use `status` frequently** - It shows everything at a glance
2. **The `--auto --verbose` combo** is most reliable for automatic startup
3. **If `--auto` hangs**, use `--verbose` or switch to manual mode
4. **Manual mode** gives you more control for debugging
5. **Always use `stop`** for clean shutdowns
6. **Check logs** if services behave unexpectedly

### 🔄 **Migration from Old Scripts**

If you were using the old separate scripts:

```bash
# Old way ❌
./start-local-dev.sh
./stop-local-dev.sh

# New way ✅
./dev.sh start
./dev.sh stop
```

The unified script provides:
- ✅ Better error handling
- ✅ Comprehensive status reporting
- ✅ Consistent command interface
- ✅ Built-in help and documentation
- ✅ Cleaner process management