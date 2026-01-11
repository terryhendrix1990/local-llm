#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "Aider running with directory ${SCRIPT_DIR}"

# -----------------------------
# Check if Ollama is running
# -----------------------------
OLLAMA_PID=$(ps aux | grep '[o]llama serve' | awk '{print $2}')
OLLAMA_STARTED=0

if [ -z "$OLLAMA_PID" ]; then
    echo "Ollama not running. Starting Ollama..."
    mkdir -p "${SCRIPT_DIR}/.aider-logs"
    ollama serve > "${SCRIPT_DIR}/.aider-logs/access.log" 2> "${SCRIPT_DIR}/.aider-logs/application.log" &
    OLLAMA_PID=$!
    OLLAMA_STARTED=1
    echo "Ollama started with PID $OLLAMA_PID"
    # Give it a few seconds to initialize
    sleep 3
else
    echo "Ollama already running with PID $OLLAMA_PID"
fi

# -----------------------------
# Cleanup function
# -----------------------------
cleanup() {
    if [ "$OLLAMA_STARTED" -eq 1 ]; then
        echo "Stopping Ollama (PID $OLLAMA_PID)..."
        kill $OLLAMA_PID
    fi
}
trap cleanup EXIT

# -----------------------------
# Run Aider in Docker
# -----------------------------
docker run -it \
  --user $(id -u):$(id -g) \
  -e OLLAMA_API_BASE=http://host.docker.internal:11434 \
  --volume "$(pwd)":/app \
  paulgauthier/aider-full --model ollama/qwen2.5-coder:14b "$@"
