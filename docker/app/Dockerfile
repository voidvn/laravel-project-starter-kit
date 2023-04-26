FROM php:8.2.4-fpm

RUN apt-get update && apt-get install -y \
      apt-utils \
      libpng-dev \
      libjpeg-dev \
      libfreetype6-dev \
      libjpeg62-turbo-dev \
      libmcrypt-dev \
      libgd-dev \
      jpegoptim optipng pngquant gifsicle \
      libonig-dev \
      libxml2-dev \
      libpq-dev \
      libpng-dev \
      libzip-dev \
      zip unzip \
      git && \
      docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg && \
      docker-php-ext-install zip pdo_mysql mbstring exif pcntl bcmath gd intl && \
      apt-get clean && \
      rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pecl install xdebug-3.2.1 && \
  docker-php-ext-enable xdebug

COPY ./docker/app/php.ini /usr/local/etc/php/conf.d/php.ini

# Install composer
ENV COMPOSER_ALLOW_SUPERUSER=1
RUN curl -sS https://getcomposer.org/installer | php -- \
    --filename=composer \
    --install-dir=/usr/local/bin \

WORKDIR /
