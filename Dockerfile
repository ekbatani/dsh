FROM node:22-bookworm-slim

# Install standard developer tooling required by the agent
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    ca-certificates \
    build-essential \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# Use the non-root node user
USER node
WORKDIR /home/node

# Globally install the DeepSeek Harness CLI
RUN npm install -g @deepseek-ai/dsh

# Set the active project directory
WORKDIR /workspace

EXPOSE 3080

ENTRYPOINT ["dsh"]
CMD ["web", "--host", "0.0.0.0", "--port", "3080"]
