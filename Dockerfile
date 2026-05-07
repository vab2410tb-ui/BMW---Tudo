FROM php:8.1-apache

# Ép Railway bỏ cache cũ, build mới hoàn toàn
ENV BUST_CACHE=1

# Cài đặt PostgreSQL driver
RUN apt-get update && apt-get install -y libpq-dev \
    && docker-php-ext-install pgsql pdo_pgsql

# Quét sạch TẤT CẢ các MPM đang bật, sau đó CHỈ bật lại đúng 1 cái prefork
RUN rm -f /etc/apache2/mods-enabled/mpm_*.load \
    && rm -f /etc/apache2/mods-enabled/mpm_*.conf \
    && a2enmod mpm_prefork

# Copy mã nguồn vào thư mục web
COPY app/ /var/www/html/

# Cấp quyền và bật rewrite
RUN chown -R www-data:www-data /var/www/html \
    && a2enmod rewrite

EXPOSE 80

# Chạy Apache
CMD ["apache2-foreground"]