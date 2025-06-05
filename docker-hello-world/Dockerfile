# Use the official nginx image as base image
FROM nginx:alpine

# Copy our HTML file to nginx's default document root
COPY index.html /usr/share/nginx/html/

# Expose port 80 to allow external access
EXPOSE 80

# nginx starts automatically with the default CMD, so no need to specify one
# RUN mkdir -p /var/log/app
# RUN echo "$(date): Container started" > /var/log/app/startup.log