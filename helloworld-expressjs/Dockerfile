# Use a Node.js base image
FROM node:14

# Create and set the working directory
WORKDIR /app

# Copy package.json and package-lock.json to install dependencies
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Set environment variables with default values
ENV LISTEN_PORT=3000
ENV APP_NAME="not set"

# Expose the application port
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
