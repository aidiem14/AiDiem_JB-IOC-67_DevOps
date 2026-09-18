#!/bin/bash

if [ "$1" != "user" ]; then
    echo "Sử dụng: ./deploy-dev.sh user"
    exit 1
fi

# 0. Di chuyển vào đúng thư mục chứa mã nguồn của service
cd /home/aidiem/workspace/AiDiem_JB-IOC-67_Microservices_Session02_Gioi01/user-service

echo "[1] Cập nhật mã nguồn mới nhất..."
git pull

echo "[2] Đang biên dịch ứng dụng..."
./gradlew clean bootJar

# Fail-fast: Dừng kịch bản ngay nếu quá trình build có lỗi
if [ $? -ne 0 ]; then
    echo -e "\e[31m[LỖI] Biên dịch thất bại! Dừng triển khai.\e[0m"
    exit 1
fi

echo "[3] Xác định cấu hình dịch vụ..."
PORT=8080
DEST_DIR="/opt/quickbite/dev/user-service"
RUN_USER="user-svc"

echo "[4] Triển khai ứng dụng..."
# Tìm và tắt tiến trình cũ đang chạy ở cổng 8080
PID=$(sudo ss -tulpn | grep :$PORT | grep -o 'pid=[0-9]*' | head -1 | cut -d= -f2)
if [ ! -z "$PID" ]; then
    echo "Tắt tiến trình cũ tại PID: $PID"
    sudo kill -9 $PID
fi

# Copy file JAR mới vào thư mục đích và cấu hình phân quyền
sudo cp build/libs/*.jar $DEST_DIR/app.jar
sudo chown $RUN_USER:quickbite-apps $DEST_DIR/app.jar

# Chạy ngầm ứng dụng
sudo -u $RUN_USER nohup java -jar $DEST_DIR/app.jar > $DEST_DIR/app.log 2>&1 &

echo "[HOÀN TẤT] Ứng dụng đang được khởi chạy ngầm trên cổng $PORT!"
