#!/bin/bash
# 1. Tạo thư mục làm việc của dự án
sudo mkdir -p /opt/quickbite/user-service

# 2. Thay đổi chủ sở hữu cho user và group quickbite
sudo chown -R quickbite:quickbite /opt/quickbite

# 3. Phân quyền thư mục là 750
sudo chmod -R 750 /opt/quickbite

# Giải thích ý nghĩa quyền 750:
# Số 7 (Chủ sở hữu - user quickbite): Có toàn quyền Đọc (4) + Ghi (2) + Thực thi (1).
# Số 5 (Nhóm - group quickbite): Có quyền Đọc (4) + Thực thi (1) để chạy ứng dụng, nhưng không được phép chỉnh sửa/ghi file.
# Số 0 (Người dùng khác - Others): Hoàn toàn không có quyền truy cập, ngăn chặn việc đọc lén file cấu hình.