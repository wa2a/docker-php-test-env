FROM php:8.1

RUN apt-get update; \
    apt-get install -y wget git default-mysql-client zlib1g-dev

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN chmod +x /usr/local/bin/install-php-extensions && sync && \
    install-php-extensions gd mbstring zip mysqli pdo_mysql xdebug @composer

RUN pear install PHP_CodeSniffer

RUN echo "xdebug.mode=coverage" >> '/usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini'

COPY line-rate.sh /usr/local/bin/line-rate
RUN chmod +x /usr/local/bin/line-rate

RUN mkdir -p /var/www/html
WORKDIR /var/www/html
