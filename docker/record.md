### 构建镜像
sudo docker build -t mygo1.16 .

### 启动镜像
sudo docker run -it --rm \
-v /var/run/docker.sock:/var/run/docker.sock \
-v $(which docker):/usr/bin/docker  \
--network k3d-test \
--name mygo1.16 \
mygo1.16


### ping安装
sudo apt install inetutils-ping

### ifconfig安装
sudo  apt install net-tools