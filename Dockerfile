FROM oven/bun:1 AS base
WORKDIR /app

FROM base AS builder
COPY package.json bun.lock ./
RUN bun install
COPY . .
RUN bun run build

FROM joseluisq/static-web-server:2
WORKDIR /app
COPY --from=builder /app/dist dist
CMD ["--port", "3000", "--root", "dist"]