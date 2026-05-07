# 1. Sử dụng hình ảnh PHP 8.1 kết hợp Apache
FROM php:8.1-apache

# 2. Cài đặt các thư viện hệ thống cần thiết cho PostgreSQL
RUN apt-get update && apt-get install -y \
    libpq-dev \
    && docker-php-ext-install pgsql pdo_pgsql

# 3. Copy toàn bộ code từ thư mục app vào thư mục chạy web của Apache
# (Đảm bảo folder 'app' của bạn chứa các file như index.php, forgotusername.php,...)
COPY app/ /var/www/html/

# 4. Tạo thư mục images và cấp quyền (Sửa lỗi Build Failed ở bước trước)
# Lệnh mkdir -p sẽ tạo thư mục nếu chưa có, tránh lỗi exit code 1
RUN mkdir -p /var/www/html/images \
    && chown -R www-data:www-data /var/www/html/images \
    && chmod -R 777 /var/www/html/images

# 5. Kích hoạt module rewrite của Apache để hỗ trợ file .htaccess (Kịch bản 6)
RUN a2enmod rewrite

# 6. Mở cổng 80 để truy cập từ Internet
EXPOSE 80

# 7. Khởi động Apache ở chế độ foreground
CMD ["apache2-foreground"]