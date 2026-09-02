#!/bin/sh
set -e

# Forward incoming TCP traffic on 0.0.0.0:3080 to loopback 127.0.0.1:3081
socat TCP4-LISTEN:3080,bind=0.0.0.0,fork,reuseaddr TCP4:127.0.0.1:3081 &

# Run DeepSeek Harness on loopback port 3081 without attempting to open desktop browser
exec dsh web --host 127.0.0.1 --port 3081 --no-open
