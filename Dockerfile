FROM node:22-bookworm-slim

# Install system dependencies + socat + gosu
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    ca-certificates \
    build-essential \
    python3 \
    socat \
    gosu \
    && rm -rf /var/lib/apt/lists/*

# Install global NPM packages
RUN npm install -g @deepseek-ai/dsh

# Setup workspace and directories
RUN mkdir -p /workspace /home/node/.dsh && \
    chown -R node:node /workspace /home/node

# Copy startup script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /workspace

EXPOSE 3080

ENTRYPOINT ["/entrypoint.sh"]
