#!/bin/sh
set -e

# Ensure directories exist
mkdir -p /home/node/.dsh /workspace

# Fix general ownership
chown -R node:node /home/node/.dsh /workspace 2>/dev/null || true
chmod 700 /home/node/.dsh 2>/dev/null || true
chmod 775 /workspace 2>/dev/null || true

# Enforce strict 600 permissions on all credential files if they exist
find /home/node/.dsh -maxdepth 2 -name "*.yaml" -exec chmod 600 {} + 2>/dev/null || true

# Forward incoming traffic on port 3080 to internal 3081
socat TCP4-LISTEN:3080,bind=0.0.0.0,fork,reuseaddr TCP4:127.0.0.1:3081 &

# Run dsh with explicitly trusted host domains
exec dsh web \
  --host 127.0.0.1 \
  --port 3081 \
  --no-open \
  --trusted-host dsh.fixo24.com \
  --trusted-host dsh-api.fixo24.com
