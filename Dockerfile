# 1. Sử dụng PHP 8.1 Apache
FROM php:8.1-apache

# 2. Cài đặt PostgreSQL driver
RUN apt-get update && apt-get install -y libpq-dev \
    && docker-php-ext-install pgsql pdo_pgsql

# 3. FIX LỖI MPM: Tắt mpm_event và bật mpm_prefork (chuẩn cho PHP)
RUN a2dismod mpm_event || true && a2enmod mpm_prefork

# 4. Copy code vào thư mục web
COPY app/ /var/www/html/

# 5. Tạo thư mục images và cấp quyền
RUN mkdir -p /var/www/html/images \
    && chown -R www-data:www-data /var/www/html/images \
    && chmod -R 777 /var/www/html/images

# 6. Bật module rewrite cho .htaccess
RUN a2enmod rewrite

EXPOSE 80

# Chạy Apache ở chế độ foreground
CMD ["apache2-foreground"]