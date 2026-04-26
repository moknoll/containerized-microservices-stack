FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    && rm -rf /var/lib/apt/lists/*

COPY ./tools/init-nginx.sh /init-nginx.sh
RUN chmod +x /init-nginx.sh

COPY ./conf/default /etc/nginx/sites-available/default

EXPOSE 443

ENTRYPOINT [ "/init-nginx.sh" ]
