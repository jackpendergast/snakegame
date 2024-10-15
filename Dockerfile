FROM alpine:latest

# Install Nginx
RUN apk update && apk add nginx

# Copy the default configuration file (you can customize this later)
COPY nginx.conf /etc/nginx/nginx.conf

# Copy static web files to Nginx's default folder
COPY ./html /usr/share/nginx/html

# Set correct permissions
RUN chmod -R 755 /usr/share/nginx/html && \
    chown -R nginx:nginx /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx in the foreground (required for Docker)
CMD ["nginx", "-g", "daemon off;"]
