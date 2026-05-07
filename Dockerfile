# Nâng cấp lên 8.2 để ép Railway tạo môi trường mới hoàn toàn
FROM php:8.2-apache

# Cài đặt PostgreSQL driver
RUN apt-get update && apt-get install -y libpq-dev \
    && docker-php-ext-install pgsql pdo_pgsql

# Tắt event/worker và bật prefork theo chuẩn hệ thống Debian mới
RUN a2dismod mpm_event mpm_worker || true \
    && a2enmod mpm_prefork

# Copy mã nguồn
COPY app/ /var/www/html/

# Cấp quyền và bật rewrite
RUN chown -R www-data:www-data /var/www/html \
    && a2enmod rewrite

EXPOSE 80