#!/bin/sh
set -e

# Forward incoming traffic on port 3080 to internal 3081
socat TCP4-LISTEN:3080,bind=0.0.0.0,fork,reuseaddr TCP4:127.0.0.1:3081 &

# Run dsh with explicitly trusted host domains
exec dsh web \
  --host 127.0.0.1 \
  --port 3081 \
  --no-open \
  --trusted-host dsh.fixo24.com \
  --trusted-host dsh-api.fixo24.com
