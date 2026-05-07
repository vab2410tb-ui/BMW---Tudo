FROM php:8.2-apache

RUN apt-get update && apt-get install -y libpq-dev \
    && docker-php-ext-install pgsql pdo_pgsql

# RESET MPM COMPLETELY
RUN a2dismod mpm_event || true
RUN a2dismod mpm_worker || true
RUN a2dismod mpm_prefork || true
RUN a2enmod mpm_prefork

RUN a2enmod rewrite

COPY app/ /var/www/html/
COPY docker/ /var/www/html/docker/

RUN chown -R www-data:www-data /var/www/html

EXPOSE 80