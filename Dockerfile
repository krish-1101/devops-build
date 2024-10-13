# Use Nginx to serve static files
FROM nginx:alpine

# Copy the build output to Nginx's public folder
COPY ./build /usr/share/nginx/html

# Copy the custom Nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose the port Nginx is running on
EXPOSE 90

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
