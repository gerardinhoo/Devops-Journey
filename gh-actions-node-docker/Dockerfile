FROM node:20-alpine
WORKDIR /app

# Install deps
COPY package*.json ./
RUN --mount=type=cache,target=/root/.npm npm ci --omit=dev

# Copy app code
COPY app.js ./

EXPOSE 3000
CMD ["npm", "start"]
