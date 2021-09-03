### 使用apk安装stress-ng
``` sh
apk add --update --no-cache make wget gcc musl-dev linux-headers ca-certificates && wget https://launchpad.net/ubuntu/+archive/primary/+files/stress-ng_0.03.12.orig.tar.gz && tar -xzf stress-ng_0.03.12.orig.tar.gz &&cd stress*/ &&make install
```
> 由于应用使用alpine linux，使用的是apk包管理器


### 压测内存
```sh
stress-ng --vm 1 --vm-bytes 600M --timeout 6000s
```
> 每个vm worker使用mmap N个字节，默认值为256MB。
可以使用后缀b，k，m或者g将大小指定为总可用内存的百分比，或者以字节，千字节，兆字节和千兆字节为单位。
" --vm 2"：将启动N个工作程序(2个工作程序)，连续调用mmap/munmap并写入分配的内存。
请注意，如果没有足够的物理内存和交换空间，这可能导致系统使Linux系统上的内核OOM杀手跳闸。

### [参考：使用Stress-ng在Linux/Unix上对CPU和内存(VM)进行压力测试](https://www.igiftidea.com/article/11801456093.html)