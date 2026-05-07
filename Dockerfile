FROM php:8.2-apache

# Chỉ cài driver Postgres, để cho Apache tự lo phần MPM mặc định của nó
RUN apt-get update && apt-get install -y libpq-dev \
    && docker-php-ext-install pgsql pdo_pgsql

COPY app/ /var/www/html/

RUN chown -R www-data:www-data /var/www/html && a2enmod rewrite

EXPOSE 80