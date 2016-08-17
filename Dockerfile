FROM php:7-apache
MAINTAINER Nicolas Steinmetz <public+docker@steinmetz.fr>
ADD https://github.com/getgrav/grav/releases/download/1.1.3/grav-admin-v1.1.3.zip /tmp/grav-admin-v1.1.3.zip
RUN apt update && \
    apt upgrade -y && \
    apt install -y \
        unzip \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        libcurl4-openssl-dev \
        pkg-config \
        libxml2-dev \
	libxml++2.6-dev \
        libyaml-0-2 \
	libyaml-dev \
        libssl-dev \
        openssl && \
    unzip /tmp/grav-admin-v1.1.3.zip -d /tmp/ && \
    mv /tmp/grav-admin/* /var/www/html/ && \
    mv /tmp/grav-admin/.htaccess /var/www/html/ && \
    chown www-data:www-data -R /var/www/html && \
    docker-php-ext-install mbstring && \
    docker-php-ext-install zip && \
    docker-php-ext-install xml && \
    #docker-php-ext-install curl && \
    #pecl install yaml && \
    #docker-php-ext-enable yaml && \
    ln -s /usr/src/php/ext/openssl/config0.m4 /usr/src/php/ext/openssl/config.m4 && \
    docker-php-ext-install openssl && \
    #docker-php-ext-install -j$(nproc) iconv mcrypt && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install -j$(nproc) gd &&\
    a2enmod rewrite && \
    rm -rf /var/lib/apt/lists/* 



