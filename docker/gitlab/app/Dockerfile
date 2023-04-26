FROM php:8.2.4-fpm

RUN apt-get update && apt-get install -y \
      apt-utils \
      libpq-dev \
      libpng-dev \
      libicu-dev \
      libzip-dev \
      zip unzip \
      git && \
      docker-php-ext-install pdo && \
      docker-php-ext-install pdo_mysql && \
      docker-php-ext-install exif && \
      docker-php-ext-install bcmath && \
      docker-php-ext-install gd && \
      docker-php-ext-install zip && \
      docker-php-ext-install intl && \
      apt-get clean && \
      rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


COPY ./docker/app/php.ini /usr/local/etc/php/conf.d/php.ini


COPY app            /var/www/app
COPY bootstrap      /var/www/bootstrap
COPY config         /var/www/config
COPY database       /var/www/database
COPY lang           /var/www/lang
COPY public         /var/www/public
COPY resources      /var/www/resources
COPY routes         /var/www/routes
COPY storage        /var/www/storage
COPY artisan        /var/www/artisan
COPY package.json   /var/www/package.json
COPY vite.config.js /var/www/vite.config.js

COPY composer.*  ./

# Install composer
ENV COMPOSER_ALLOW_SUPERUSER=1
RUN curl -sS https://getcomposer.org/installer | php -- \
    --filename=composer \
    --install-dir=/usr/local/bin
# alias
RUN echo "alias a='artisan'" >> /root/.bashrc

RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs
# RUN npm i

RUN composer update \
      install \
      --no-interaction \
      --no-plugins \
      --no-suggest \
      --no-scripts \
      --no-autoloader \
      --prefer-dist

RUN composer dump-autoload  --no-scripts --optimize && \
    chown -R root:www-data /var/www && \
    chmod 755 -R /var/www && \
    chmod -R 775 /var/www/storage && \
    chmod -R 775 /var/www/bootstrap/cache

WORKDIR /var/www
