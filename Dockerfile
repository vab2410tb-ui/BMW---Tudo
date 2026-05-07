FROM php:8.1-apache

# Cài đặt Postgres Driver
RUN apt-get update && apt-get install -y libpq-dev \
    && docker-php-ext-install pgsql pdo_pgsql

# Xóa sạch mọi MPM mặc định và ép dùng prefork
RUN rm -f /etc/apache2/mods-enabled/mpm_*.load \
    && rm -f /etc/apache2/mods-enabled/mpm_*.conf \
    && a2enmod mpm_prefork

# Copy source code
COPY app/ /var/www/html/

# Phân quyền và bật rewrite
RUN chown -R www-data:www-data /var/www/html \
    && a2enmod rewrite

EXPOSE 80