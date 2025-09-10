# Dockerfile
FROM node:20-alpine
WORKDIR /app

# Install deps first for better layer caching
COPY package*.json ./
RUN npm ci --omit=dev

# Copy the rest of the app
COPY . .

# Optional: tell your app what port to use
ENV PORT=3000
EXPOSE 3000

# Start it (use "node app.js" if you don't have an npm start)
CMD ["npm", "start"]
