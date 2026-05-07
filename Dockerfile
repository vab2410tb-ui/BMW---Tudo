FROM php:8.1-apache

RUN apt-get update && apt-get install -y libpq-dev \
    && docker-php-ext-install pgsql pdo_pgsql

# Xóa trực tiếp file load mpm_event để triệt tiêu xung đột
RUN rm -f /etc/apache2/mods-enabled/mpm_event.load
RUN a2enmod mpm_prefork

COPY app/ /var/www/html/

RUN chown -R www-data:www-data /var/www/html && a2enmod rewrite

EXPOSE 80
# Sử dụng lệnh mặc định của image gốc để chạy Apache ổn định nhất
CMD ["apache2-foreground"]