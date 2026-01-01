#!/usr/bin/env bash
set -e

echo "🚀 Starting AI Trip Planner..."

# Always run relative to the script location
ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "📡 Starting backend server..."

(
  cd "$ROOT_DIR/backend"
  uv run uvicorn main:app --host 0.0.0.0 --port 8000 --reload
) &

BACKEND_PID=$!
echo "Backend started with PID: $BACKEND_PID"

echo ""
echo "✅ Service started successfully!"
echo "📡 Backend API: http://localhost:8000"
echo "🖥️  Minimal UI served at / (frontend/index.html)"
echo "📊 Arize Traces: https://app.arize.com/"
echo ""
echo "Press Ctrl+C to stop the service"

wait