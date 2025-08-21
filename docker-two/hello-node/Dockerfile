# 1) base runtime
FROM node:20-alpine

# 2) working dir
WORKDIR /app

# 3) install deps first (cache)
COPY package*.json ./
RUN npm ci --only=production

# 4) copy app code
COPY . .

# 5) drop privileges
RUN addgroup -S app && adduser -S app -G app
USER app

# 6) network & start
EXPOSE 3000
CMD ["npm", "start"]
