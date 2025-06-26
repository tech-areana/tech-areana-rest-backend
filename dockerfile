########################
# 1. build stage
########################
FROM node:18-slim AS build
WORKDIR /app

COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build                     # build/ へ JS 出力

# ★ YML を build/docs/ にコピー（パスは実際の配置に合わせてください）
RUN mkdir -p build/docs && cp src/docs/openapi.yml build/docs/

########################
# 2. production stage
########################
FROM node:18-slim
WORKDIR /app

COPY package*.json ./
RUN npm ci --omit=dev                

COPY --from=build /app/build ./build 

EXPOSE 8000
CMD ["node", "build/server.js"]
