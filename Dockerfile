FROM php:8.1-apache

RUN apt-get update && apt-get install -y libpq-dev \
    && docker-php-ext-install pgsql pdo_pgsql

# RESET TO ONLY PREFORK
RUN rm -f /etc/apache2/mods-enabled/mpm_*.load \
    && rm -f /etc/apache2/mods-enabled/mpm_*.conf \
    && a2enmod mpm_prefork

RUN a2enmod rewrite

COPY app/ /var/www/html/

RUN mkdir -p /var/www/html/images \
    && chown -R www-data:www-data /var/www/html \
    && chmod -R 777 /var/www/html/images

EXPOSE 80

CMD ["apache2-foreground"]