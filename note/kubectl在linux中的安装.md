### 版本
kubernetes：1. 21.3

### linux下的安装方式
- 下载kubectl
```
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.21.3/bin/linux/amd64/kubectl
```
- 更改权限
``` shell
chmod +x ./kubectl
```
- 将二进制文件移动到PATH中
``` shell
sudo mv ./kubectl /usr/local/bin/kubectl
```
- 验证
``` shell
kubectl cluster-info
```

### 参考
[安装和设置kubectl](https://www.kubernetes.org.cn/installkubectl)