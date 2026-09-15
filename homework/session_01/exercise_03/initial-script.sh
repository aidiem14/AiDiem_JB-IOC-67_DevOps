#!/bin/bash

echo "Đang cập nhật hệ thống..."
sudo apt-get update && sudo apt-get upgrade -y

echo "Đang cài đặt JDK 17, Git và Curl..."
sudo apt-get install -y openjdk-17-jdk git curl

echo "Kiểm tra và cấu hình tài khoản hệ thống..."
# Kiểm tra nếu group quickbite chưa tồn tại thì tạo mới
if ! getent group quickbite > /dev/null 2>&1; then
    sudo groupadd quickbite
    echo "Đã tạo nhóm quickbite."
fi

# Kiểm tra nếu user quickbite chưa tồn tại thì tạo mới với các cờ bảo mật
if ! getent passwd quickbite > /dev/null 2>&1; then
    sudo useradd -r -g quickbite -s /bin/false quickbite
    echo "Đã tạo user quickbite."
fi

echo "Hoàn tất kịch bản cài đặt!"
