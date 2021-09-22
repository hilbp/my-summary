## <center>Jenkins共享库集中管理构建部署文件的总结</center>

### 一、构建相关的文件

- `Dockerfile`
- `Dockefile`中通过`ADD`指令添加的一些静态文件（不包含流水线构建过程生成的文件，如jar）
- 部署时用到的yml文件

### 二、之前实践中遇到的问题

构建相关文件散落在源码库各分支，修改时，需拉取代码库进行修改。这样存在以下问题

- 如果维护的库和流水线较多，那么修改起来不方便
- 流水线较多时，不便于统一维护、管理

**所以，能否将所有的构建相关的文件进行集中管理呢？**

答案是肯定的。

### 三、流程

1. 流水线开始运行时，从Jenkins共享库加载构建相关的文件
2. 在构建的git库拉去之后，在库的根目录的devops文件中，写入所有构建相关文件
3. 开始构建流程

### 四、实现

1. Jenkins共享库加载后保存在Jenkins service的 JENKINS_HOME所指向的目录，通过对其下文件的研究，找到了共享库的保存位置，可通过环境变量进行构造来找到`resources`目录下的文件

```groovy
def jobName = env.JOB_NAME
def namespace = jobName.split('/')[0]
def path = "${JENKINS_HOME}/jobs/${namespace}/jobs/${JOB_BASE_NAME}/builds/${BUILD_NUMBER}/libs/jenkins-shared-lib/resources/"
```

2. 然后遍历`resources`目录来实现文件读取

```groovy
def jobName = env.JOB_NAME
def namespace = jobName.split('/')[0]
def jobBaseName = jobName.split('/')[1] 
def path = "${JENKINS_HOME}/jobs/${namespace}/jobs/${jobBaseName}/builds/${BUILD_NUMBER}/libs/jenkins-shared-lib/resources/"

//resources下文件遍历
File dir = new File(path)
File[] files = dir.listFiles()
for(File item in files) {
    //打印文件名称
    println item.name
    
    //使用:读取后写入当前构建项目的devops目录（建议与git库源码的根目录下）
    def filePath = "${env.WORKSPACE}/{APP_NAME}/devops/"
    writeFile file: "${filePath}/${item.name}", text: file_contents, encoding: "UTF-8"
    
}
```

3. 然后在共享库实现中，在适合的步骤中结合以上步骤，完成构建部署文件集中管理的需要。

比如Dockerfile的保存路径是：
`resources/${APP_NAME}/docker`

其中的文件有：
- Dockerfile
- k8s的部署yml
-   其他需要使用docker ADD/COPY指令拷贝的文件

使用方式:

```groovy
...

def path = "${JENKINS_HOME}/jobs/${namespace}/jobs/${jobBaseName}/builds/${BUILD_NUMBER}/libs/jenkins-shared-lib/resources/${APP_NAME}/docker/"

//resources下文件遍历
File dir = new File(path)
File[] files = dir.listFiles()
for(File item in files) {

    //打印文件名称
    println item.name
    
    //使用:读取后写入当前构建项目的devops目录（建议与git库源码的根目录下）
    def filePath = "${env.WORKSPACE}/{APP_NAME}/devops/"
    writeFile file: "${filePath}/${item.name}", text: libraryResource("${APP_NAME}/docker/${item.name}"), encoding: "UTF-8"
    
}
```

4. Jenkins相关环境变量记录

```groovy
println "BUILD_DISPLAY_NAME: " + env.BUILD_DISPLAY_NAME
println "JOB_NAME: " + env.JOB_NAME
println "JOB_BASE_NAME: " + env.JOB_BASE_NAME
println "WORKSPACE: " + env.WORKSPACE
println "WORKSPACE_TMP: " + env.WORKSPACE_TMP
println "JENKINS_HOME: " + env.JENKINS_HOME
```

