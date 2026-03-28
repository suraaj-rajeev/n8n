#!/bin/sh
set -e
# Render sets PORT; n8n listens on N8N_PORT (see https://docs.n8n.io/hosting/configuration/environment-variables/)
export N8N_PORT="${PORT:-5678}"
export N8N_LISTEN_ADDRESS="${N8N_LISTEN_ADDRESS:-0.0.0.0}"
exec /docker-entrypoint.sh start
