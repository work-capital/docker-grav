FROM php:7-apache
MAINTAINER Nicolas Steinmetz <public+docker@steinmetz.fr>
ADD https://github.com/getgrav/grav/releases/download/1.2.0/grav-admin-v1.2.0.zip /tmp/grav-admin-v1.2.0.zip
RUN apt update && \
    apt upgrade -y && \
    apt install -y \
        unzip \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libmcrypt-dev \
        libpng12-dev \
        pkg-config && \
    unzip /tmp/grav-admin-v1.2.0.zip -d /tmp/ && \
    mv /tmp/grav-admin/* /var/www/html/ && \
    mv /tmp/grav-admin/.htaccess /var/www/html/ && \
    chown www-data:www-data -R /var/www/html && \
    docker-php-ext-install -j$(nproc) mcrypt && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install -j$(nproc) gd &&\
    docker-php-ext-install -j$(nproc) zip &&\
    a2enmod rewrite && \
    rm -rf /var/lib/apt/lists/*
COPY php.conf /etc/apache2/conf-enabled/
COPY server-signature.conf /etc/apache2/conf-enabled/