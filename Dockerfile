FROM nginx:1.21-alpine

COPY index.html /usr/share/nginx/html/

EXPOSE 80
