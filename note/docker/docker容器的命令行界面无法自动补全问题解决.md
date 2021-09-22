### 问题描述
Dockerfile中使用
```Dockerfile
CMD ["/bin/sh"]
```
时，进入容器命令后，输入命令时无法提示命令补全。

### 问题分析
通过
```sh
ls -kl /bin/sh
```
输出 
```sh
/bin/sh -> dash
```
可知当前shell命令的执行是使用dash。

[关于bash和dash的区别，参考 https://www.cnblogs.com/macrored/p/11548347.html](https://www.cnblogs.com/macrored/p/11548347.html)

### 解决方案
网上看了一大堆解决方案，感觉太复杂了，最简单的解决方案是：
```Dockerfile
CMD ["/bin/bash"]
```