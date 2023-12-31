FROM php:8.1-fpm

WORKDIR \svtechnologies

#composer
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

#add composer to path
ENV PATH="$PATH:/usr/local/bin/composer"



RUN apt-get update && apt-get install -y \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath

COPY . .

RUN composer install 

CMD php artisan serve --host=0.0.0.0 --port=8000
