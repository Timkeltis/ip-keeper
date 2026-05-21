#!/bin/bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT_DIR"

LOG_FILE="/tmp/ipkeeper.log"

is_server_ready() {
  curl -fs "http://127.0.0.1:5678/api/diagnostic" >/dev/null 2>&1
}

open_browser() {
  open -a "Google Chrome" "http://localhost:5678" 2>/dev/null || \
  open -a "Safari" "http://localhost:5678" 2>/dev/null || \
  open "http://localhost:5678"
}

if [ ! -f "server.py" ] || [ ! -f "static/index.html" ]; then
  osascript -e 'display dialog "未找到 server.py 或 static/index.html\n\n请把解压后的所有文件放在同一个文件夹里，再重新启动。" buttons {"确定"} default button 1 with icon stop with title "知产管家"' 2>/dev/null || true
  exit 1
fi

if ! command -v python3 >/dev/null 2>&1; then
  osascript -e 'display dialog "未找到 Python 3\n\n请先安装 Python 3 后再启动。" buttons {"确定"} default button 1 with icon stop with title "知产管家"' 2>/dev/null || true
  exit 1
fi

if is_server_ready; then
  open_browser
  exit 0
fi

if lsof -ti:5678 >/dev/null 2>&1; then
  pkill -f "server.py" 2>/dev/null || true
  sleep 1
fi

python3 -m pip install flask openpyxl --quiet --break-system-packages 2>/dev/null || \
python3 -m pip install flask openpyxl --quiet 2>/dev/null || true

: > "$LOG_FILE"
nohup python3 server.py >"$LOG_FILE" 2>&1 &
SERVER_PID=$!

for _ in {1..30}; do
  if is_server_ready; then
    open_browser
    exit 0
  fi
  if ! kill -0 "$SERVER_PID" 2>/dev/null; then
    break
  fi
  sleep 0.5
done

osascript -e "display dialog \"服务器启动失败。\n\n请查看日志：\n${LOG_FILE}\" buttons {\"确定\"} default button 1 with icon stop with title \"知产管家\"" 2>/dev/null || true
exit 1
