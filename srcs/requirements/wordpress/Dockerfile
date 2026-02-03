FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    php-mysqli \
    php-fpm \
    curl \
    && rm -rf /var/lib/apt/lists/*

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY ./tools/init-wp.sh /init-wp.sh
RUN chmod +x /init-wp.sh

EXPOSE 9000

CMD [ "/init-wp.sh" ]