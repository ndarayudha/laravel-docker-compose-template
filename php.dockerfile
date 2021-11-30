FROM php:8.0.5-fpm-alpine

RUN mkdir -p /var/www/html

RUN rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*

RUN apk update && apk upgrade

RUN apk --no-cache add nano git zip unzip curl vim

RUN apk --no-cache add shadow && usermod -u 1000 www-data

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

RUN install-php-extensions pdo_mysql zip sockets @composer