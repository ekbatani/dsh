FROM node:22-bookworm

RUN npm install -g @deepseek-ai/dsh

WORKDIR /app

EXPOSE 3000

CMD ["dsh", "web"]
