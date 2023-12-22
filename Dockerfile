# Dockerfile
 
# Use an existing node alpine image as a base image.
FROM node:18-alpine as build
 
# Set the working directory.
WORKDIR /app
 
# Copy the package.json file.
COPY package*.json ./
 
# Install application dependencies.
RUN npm install
 
# Copy the rest of the application files.
COPY . ./
 
 RUN npm run build

FROM nginx:stable-alpine

COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
