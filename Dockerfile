FROM nginx:alpine
COPY . /usr/share/nginx/html
COPY nginx.conf /etc/nginx
COPY nginx.conf /usr/share/nginx/conf
COPY nginx.conf /usr/share/etc/nginx
COPY nginx.conf /usr/share/etc/nginx/sites-enabled/default
