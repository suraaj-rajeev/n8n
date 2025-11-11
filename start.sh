#!/usr/bin/env bash
set -e

# Ensure n8n user folder exists with safe permissions
mkdir -p /home/node/.n8n
chmod 700 /home/node/.n8n
[ -f /home/node/.n8n/config ] && chmod 600 /home/node/.n8n/config || true

# Render injects $PORT — n8n must bind to it
export N8N_PORT="${PORT}"

exec n8n start
