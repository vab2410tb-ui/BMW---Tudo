FROM php:8.1-apache

# 1. Cài đặt PostgreSQL driver
RUN apt-get update && apt-get install -y libpq-dev \
    && docker-php-ext-install pgsql pdo_pgsql

# 2. ÉP TẮT module xung đột bằng lệnh chuẩn
RUN a2dismod -f mpm_event || true
RUN a2enmod mpm_prefork

# 3. Copy mã nguồn
COPY app/ /var/www/html/

# 4. Quyền hạn và rewrite
RUN chown -R www-data:www-data /var/www/html && a2enmod rewrite

EXPOSE 80
CMD ["apache2-foreground"]