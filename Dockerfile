# Sử dụng hình ảnh PHP chính thức có sẵn Apache
FROM php:8.1-apache

# Cài đặt các thư viện cần thiết cho PostgreSQL
RUN apt-get update && apt-get install -y libpq-dev \
    && docker-php-ext-install pgsql pdo_pgsql

# Copy toàn bộ nội dung thư mục app vào thư mục web của Apache
# Lưu ý: Nếu code của bạn nằm trong thư mục app/, hãy dùng lệnh dưới
COPY app/ /var/www/html/

# Bật module rewrite để file .htaccess hoạt động
RUN a2enmod rewrite

# Cấp quyền cho thư mục images để có thể upload ảnh (Kịch bản 6)
RUN chmod -R 777 /var/www/html/images

EXPOSE 80