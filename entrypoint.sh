#!/bin/sh
set -e

# Forward incoming external traffic on 3080 to loopback 3081
socat TCP-LISTEN:3080,fork,reuseaddr TCP:127.0.0.1:3081 &

# Run DeepSeek Harness on loopback port 3081
exec dsh web --host 127.0.0.1 --port 3081
