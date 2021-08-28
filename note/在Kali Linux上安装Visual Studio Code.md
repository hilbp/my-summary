<center>在Kali Linux上安装Visual Studio Code</center>

1. 使用官方的APT存储库在Kali Linux上安装Visual Studio Code。在添加存储库之前，请更新系统并安装以下软件包。
``` shell
sudo apt update
sudo apt install curl gpg software-properties-common apt-transport-https 
```
2. 将Microsoft GPG密钥导入Kali Linux。
```shell
curl -sSL https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
```
3. 接下来，将VS Code APT存储库添加到Kali Linux。
``` shell
echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
```
4. 最后，在Kali Linux上安装Visual Studio Code。
``` shell
sudo apt update
sudo apt install code
```

请耐心等待，开始在Kali Linux上安装VS Code。根据您的互联网状况，这应该是一个快速的过程。

[参考: https://www.cnblogs.com/xingxinhu/p/13796704.html](https://www.cnblogs.com/xingxinhu/p/13796704.html)