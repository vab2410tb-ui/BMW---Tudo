FROM php:8.1-apache

# Cài đặt PostgreSQL driver
RUN apt-get update && apt-get install -y libpq-dev \
    && docker-php-ext-install pgsql pdo_pgsql

# Copy mã nguồn vào thư mục web
COPY app/ /var/www/html/

# Phân quyền và bật rewrite
RUN chown -R www-data:www-data /var/www/html \
    && a2enmod rewrite

EXPOSE 80

# ÉP BUỘC TẮT MPM EVENT NGAY LÚC KHỞI ĐỘNG (RUNTIME)
# Lệnh này sẽ chạy mỗi khi server bật lên, đảm bảo 100% không bao giờ bị nạp 2 MPM
CMD bash -c "a2dismod mpm_event mpm_worker || true && a2enmod mpm_prefork || true && apache2-foreground"