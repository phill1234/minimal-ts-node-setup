# Stage 1: Build TypeScript
FROM node:21-slim AS build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# Stage 2: Run Express
FROM node:21-slim

WORKDIR /app
COPY --from=build /app/package*.json ./
RUN npm install --only=production

COPY --from=build /app/dist .

EXPOSE 3000

CMD ["node", "index.js"]
