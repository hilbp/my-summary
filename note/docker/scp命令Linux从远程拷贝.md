(1)从本地拷贝文件到远程服务器
scp /opt/script/test.pl root@192.168.3.130:~/
将本地/opt/scritp/文件夹下的test.pl脚本文件拷贝到远程服务器192.168.3.130的用户目录下。

(2)从远程服务器拷贝文件到本地
http://www.baidu.com
scp root@192.168.3.130:~/test.pl /opt/script/
将远程服务器192.168.3.130用户目录下的test.pl文件拷贝到本地/opt/scritp/文件夹下