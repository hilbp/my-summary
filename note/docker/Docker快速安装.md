### 快速安装docker
```sh
curl -sSL https://get.docker.com/ | sh
```

### 把当前用户加入docker组
```sh
usermod -aG docker $USER
```

### 开机启动docker
```sh
systemctl enable docker
```