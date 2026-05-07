FROM php:8.1-apache

# Cài đặt PostgreSQL driver
RUN apt-get update && apt-get install -y libpq-dev \
    && docker-php-ext-install pgsql pdo_pgsql

# Sửa lỗi MPM: Xóa trực tiếp file load của mpm_event và bật prefork
RUN rm -f /etc/apache2/mods-enabled/mpm_event.load
RUN a2enmod mpm_prefork

# Copy mã nguồn vào thư mục web
COPY app/ /var/www/html/

# Cấp quyền và bật module rewrite
RUN chown -R www-data:www-data /var/www/html && a2enmod rewrite

EXPOSE 80

# Chạy Apache ở chế độ foreground
CMD ["apache2-foreground"]