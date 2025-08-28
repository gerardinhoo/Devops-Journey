FROM node:20-alpine
ENV NODE_ENV=production
WORKDIR /app
COPY package*json ./
RUN npm ci --omit=dev
COPY . .
USER node
EXPOSE 3001
CMD ["npm", "start"]