FROM php:7.4-fpm

RUN apt-get update && apt-get install -y libzip-dev

# Extension zip for laravel
RUN docker-php-ext-install zip 

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN composer global require laravel/installer

#docker run -it -v $(pwd):/var/www/html localcomposer:latest /root/.composer/vendor/bin/laravel new app
#docker run -it -v ${pwd}:/var/www/html localcomposer:latest /root/.composer/vendor/bin/laravel new app