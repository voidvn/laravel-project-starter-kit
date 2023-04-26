FROM php:8.2.4-fpm

RUN apt-get update && apt-get install -y \
    libpq-dev \
    libpng-dev \
    libzip-dev \
    zip \
    unzip \
    curl \
    ffmpeg \
    libonig-dev \
    libxml2-dev

RUN docker-php-ext-install \
    zip \
    pdo_mysql \
    mbstring \
    exif \
    pcntl \
    bcmath \
    gd \
    intl\
    && docker-php-ext-enable opcache

# Install Supervisor
RUN apt-get install -y supervisor

RUN mkdir -p "/etc/supervisor/logs"

CMD ["/usr/bin/supervisord", "-n", "-c",  "/etc/supervisor/supervisord.conf"]
