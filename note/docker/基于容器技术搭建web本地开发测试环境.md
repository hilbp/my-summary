##  <center>基于容器技术搭建web本地开发测试环境</center>

### 背景
在之前的开发中，时常需要安装很多开发测试的软件，比如一个全栈开发人员需要下载安装各类软件：
-  各种开发语言的ide
-  各语言的运行环境，比如java的jdk，python运行环境等
-  各种构建工具，比如maven，npm
-  服务运行容器像nginx，apache
-  数据库，像mysql，以及数据库可视化工具等
-  其他一些开发测试中用到的软件等
这样安装下来，一是浪费时间，二是耗费电脑资源，这里除了一些像ide等软件需要桌面化软件来提升体验和开发效率，其他的软件是否有更简单的的搭建方式呢？

**答案是肯定的，就是利用容技术，docker和k8s相关技术**。

### 目标
1. **开发环境**：windows，安装ide，提升开发体验和开发效率
2. **运行环境**：docker，先在wsl2安装docker，再把应用运行环境，包括语言运行环境，web容器，数据库（这里是mysql）和mysql可视化工具phpmyadmin，构建工具等全部用容器来管理。
3. **源码共享**： 一个问题，这里开发是在windows的ide，源码保存在windows的磁盘上，比如保存在D盘的`D:\myproject`目录；运行又是在wsl2的docker中，那么ide开发的代码docker中怎么可见呢？其实wsl2可能看到windows的磁盘，然后把磁盘在启动容器时挂在到容器，操作命令如下：

``` sh
## 在wsl2访问windows磁盘，比如访问D盘
cd /mnt/d
## 比如访问项目目录
cd /mnt/d/myproject

## 容器要运行源码时，把项目挂在到容器
docker run -it --rm \
- v /mnt/d/myproject:/home/myproject \
--name  mydevruntime-v1 \
mydevruntime:v1
```
> 这里只演示让容器可见windows开发的项目，至于`myruntime`是下文将要介绍的通过Dockerfile构建的镜像；保存相关dockerfile就好，啥时候需要，啥时候利用dockerfile拉起镜像即刻，非常方便！

4. **应用访问**：另外一个问题，同样开发的源码在windows中，运行又在wsl2的docker中，那么应用运行起来后，怎么通过windows的浏览器进行访问呢？其实当windows安装wsl2系统时，windows会在windows系统和wsl2系统创建两个虚拟网卡，这两个网卡属于同一网段，ping是互通的，当启动容器时，将wsl2的端口（比如38080端口）映射到容器中应用的端口（比如8080端口），那么在windows访问wsl2的ip:38080就可以访问应用了，具体操作如下：

``` sh
## 关于wsl2和windows网络互访，以下命令中列出的网卡中，找到属于统一网段的ip
ipconfig # windows中查看网卡  输出：172.15.0.1
ifconfig # wsl2中使用命令查看网卡  输出：172.15.0.10

## wsl2启动容器时端口映射，这里将主机38080端口映射到容器的8080端口
docker run -it --rm \
- v /mnt/d/myproject:/home/myproject \
-p 38080:8080 \
--name  mydevruntime-v1 \
mydevruntime:v1
```
> 那么，在windows的浏览器访问： `http://172.15.0.10:38080`就可以访问应用了。

### 环境需求总结
- windows：安装开发ide
- wsl2：安装docker，关于wsl2的开启，作为开发人员应该有所耳闻
- docker：运行英语
- k8s：可能需要，用于模拟应用上运，下文会讲到。

### 需求
比如有这样一个需求，开发一个spring boot项目，在windows利用eclipse开发，在docker中构建且运行它，并且要方便管理jdk，maven的版本，可能需要测试项目在java8和java11上运行的性能和兼容性问题，maven版本可能也有所要求，maven版本太低或者太高都可能导致构建失败。
####  分析
这样的场景很常见，传统的做法是在windows开发，运行，测试。但可能要装多个版本的jdk，多个版本的maven，需要来回切换，这在以前，没有选择，也就这样了，但docker确实能够对其进行优化，使得开发测试更加方便快捷，通过Dockerfile来管理运行环境。

### 实现
#### 1. 构建应用运行镜像：
根据场景，目前只是单纯的java应用，所以docker hub找java的基础镜像就可以，这里基础镜像先使用java8的版本（java:8u313-jre），后期测试java11的只需要将基础镜像改成java11相关的版本就可以了。Dockerfile如下：
``` Dockerfile
FROM java:8u313-jre #基础镜像
LABEL maintainer example <example@example.com>

# 更新软件，注意所单独的层，缓存提升构建速度
RUN apt update 

# 安装maven，使构建运行在同容器进行便于开发测试
RUN curl -LO https://dlcdn.apache.org/maven/maven-3/3.8.2/binaries/apache-maven-3.8.2-bin.tar.gz && \
tar -zxvf apache-maven-3.6.3-bin.tar.gz && \
## TODO: maven安装

EXPOSE 8080
```

#### 2. 构建镜像
``` Dockerfile
docker build -t myruntime:v1 .
```

#### 3.  启动镜像并进入容器
``` Dockerfile
docker run -it --rm \
- v /mnt/d/myproject:/home/myproject \
-p 38080:8080 \
--name  mydevruntime-v1 \
mydevruntime:v1
```
#### 4. 构建及运行应用
``` sh
## 进入项目路径
mvn clean package

## 运行项目
java -jar target/xxxx.jar

```
#### 5. 浏览器访问应用
`http://172.15.0.10:38080`

### 建议
1. 可以将前后端构建工具包全部放在一个Dockerfile，安装方式就是使用`RUN`命令。
2. 涉及切换不同版本的环境时，只需改动Dockerfile后重新构建运行镜像即可，非常方便。



