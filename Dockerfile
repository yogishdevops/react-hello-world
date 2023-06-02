# Base image with Node.js installed
FROM node:14-alpine as build

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and package-lock.json files to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the entire React app to the working directory
COPY . .

# Build the React app
RUN npm run build

# Use NGINX as the production server
FROM nginx:alpine

# Copy the build output from the previous stage to the NGINX HTML folder
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 to allow incoming traffic
EXPOSE 80

# Start NGINX server when the container starts
CMD ["nginx", "-g", "daemon off;"]

