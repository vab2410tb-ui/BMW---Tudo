<?php
    if (!isset($db)) {
        // Lấy thông tin từ các Variables bạn đã add trên Railway
        $r_host = getenv('PGHOST');
        $r_port = getenv('PGPORT');
        $r_db   = getenv('PGDATABASE');
        $r_user = getenv('PGUSER');
        $r_pass = getenv('PGPASSWORD');

        // Tạo chuỗi kết nối động dựa trên môi trường thực tế
        $con_str = "host=$r_host port=$r_port dbname=$r_db user=$r_user password=$r_pass";
        
        $db = pg_connect($con_str);

        if (!$db) {
            // Log lỗi ra hệ thống của Railway thay vì hiện lên màn hình (Bảo mật)
            error_log("Connection failed using: " . $con_str);
            echo "Error: Unable to connect to database.";
        }
    }
?>