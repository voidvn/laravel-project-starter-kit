FROM php:8.2.4-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libpq-dev \
    libzip-dev \
    zip \
    unzip \
    ffmpeg \
    cron

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install zip pdo pdo_pgsql pgsql mbstring exif pcntl bcmath gd

ADD /docker/app/cron/crontab /etc/cron.d/crontab

# Update the crontab file permission
RUN chmod 0644 /etc/cron.d/crontab

# Specify crontab file for running
RUN crontab /etc/cron.d/crontab


# Set working directory
WORKDIR /var/www

RUN mkdir -p "/etc/supervisor/logs"
RUN touch /var/log/cron.log

CMD cron && tail -f /var/log/cron.log
