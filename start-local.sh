#!/usr/bin/env bash
set -e

# Local development script for Windows/Unix
# Creates .n8n directory in current folder instead of /home/node

mkdir -p ./.n8n
[ -f ./.n8n/config ] && chmod 600 ./.n8n/config 2>/dev/null || true

# Use PORT from environment or default to 5678
export N8N_PORT="${PORT:-5678}"

exec n8n start
