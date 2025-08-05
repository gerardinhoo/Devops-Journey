# Use official Node.js LTS image
FROM node:18

# Create app directory
WORKDIR /app

# Copy files
COPY package*.json ./
RUN npm install

COPY . .

# Expose port
EXPOSE 8080

# Run the app
CMD ["npm", "start"]
