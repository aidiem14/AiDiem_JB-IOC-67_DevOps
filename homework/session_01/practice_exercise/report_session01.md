# 1. Tạo nhóm quickbite-apps
sudo groupadd quickbite-apps

# 2. Tạo system user user-svc không có home dir, khóa shell
sudo useradd -r -g quickbite-apps -s /bin/false user-svc

# 3. Tạo cấu trúc thư mục Dev
sudo mkdir -p /opt/quickbite/dev/user-service

# 4. Thay đổi quyền sở hữu (ownership)
sudo chown -R user-svc:quickbite-apps /opt/quickbite/dev/user-service

# 5. Cấp quyền hạn 750
sudo chmod -R 750 /opt/quickbite/dev/user-service