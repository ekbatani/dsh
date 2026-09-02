FROM node:22-bookworm-slim

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    ca-certificates \
    build-essential \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# Install global NPM packages as root
RUN npm install -g @deepseek-ai/dsh

# Prepare workspace and config directories with non-root ownership
RUN mkdir -p /workspace /home/node/.dsh && \
    chown -R node:node /workspace /home/node

# Switch to non-root user for runtime
USER node
WORKDIR /workspace

EXPOSE 3080

ENTRYPOINT ["dsh"]
CMD ["web", "--host", "0.0.0.0", "--port", "3080"]
