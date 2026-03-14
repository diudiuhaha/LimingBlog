---
title: Docker入门笔记2
published: 2020-11-03 20:33:00
tags:
  - docker
  - 入门笔记
category: 学习笔记
image: api
slug: docker-getting-started-part-2
---


# 前言
目前环境为centos7 64位

    [root@diudiu ~]# cat /proc/version 
    Linux version 3.10.0-514.26.2.el7.x86_64 (builder@kbuilder.dev.centos.org) (gcc version 4.8.5 20150623 (Red Hat 4.8.5-11) (GCC) ) #1 SMP Tue Jul 4 15:04:05 UTC 2017

Docker版本为
主要参考W3C的相关课程
 [w3cschool][1]

## Docker 的使用
### Docker容器的使用
* 暂时没看明白
### Docker镜像使用
- 列出镜像表
```docker
[root@diudiu ~]# docker images
REPOSITORY（镜像仓库源）  TAG（镜像标签）IMAGE ID（镜像ID）   CREATED（镜像创建时间） SIZE（大小）
docker.io/ubuntu        18.04               ccc6e87d482b        12 days ago         64.2 MB
docker.io/hello-world   latest              fce289e99eb9        13 months ago       1.84 kB
```

同一仓库源可以有多个 TAG，代表这个仓库源的不同个版本
REPOSTITORY:TAG 来定义不同的镜像,如ubuntu:18.04

- 获取镜像

    docker pull ubuntu:18.04

-搜索镜像

    docker search mysql

- 创建镜像
资料不详，后续再补充

- 镜像更新
```VIM
[root@diudiu ~]# docker run -t -i ubuntu:18.04 /bin/bash
root@727f76003c9f:/# apt-get update
Get:1 http://security.ubuntu.com/ubuntu bionic-security InRelease [88.7 kB]                        
Get:2 http://archive.ubuntu.com/ubuntu bionic InRelease [242 kB]
Get:3 http://security.ubuntu.com/ubuntu bionic-security/universe amd64 Packages [807 kB]
Get:4 http://archive.ubuntu.com/ubuntu bionic-updates InRelease [88.7 kB]       
Get:5 http://archive.ubuntu.com/ubuntu bionic-backports InRelease [74.6 kB]       
Get:6 http://archive.ubuntu.com/ubuntu bionic/universe amd64 Packages [11.3 MB]
Get:7 http://security.ubuntu.com/ubuntu bionic-security/main amd64 Packages [795 kB]               
Get:8 http://security.ubuntu.com/ubuntu bionic-security/restricted amd64 Packages [25.2 kB]        
Get:9 http://security.ubuntu.com/ubuntu bionic-security/multiverse amd64 Packages [6779 B]         
Get:10 http://archive.ubuntu.com/ubuntu bionic/multiverse amd64 Packages [186 kB]                  
Get:11 http://archive.ubuntu.com/ubuntu bionic/main amd64 Packages [1344 kB]                       
Get:12 http://archive.ubuntu.com/ubuntu bionic/restricted amd64 Packages [13.5 kB]                 
Get:13 http://archive.ubuntu.com/ubuntu bionic-updates/main amd64 Packages [1090 kB]               
Get:14 http://archive.ubuntu.com/ubuntu bionic-updates/restricted amd64 Packages [39.9 kB]         
Get:15 http://archive.ubuntu.com/ubuntu bionic-updates/universe amd64 Packages [1339 kB]           
Get:16 http://archive.ubuntu.com/ubuntu bionic-updates/multiverse amd64 Packages [10.8 kB]         
Get:17 http://archive.ubuntu.com/ubuntu bionic-backports/main amd64 Packages [2496 B]              
Get:18 http://archive.ubuntu.com/ubuntu bionic-backports/universe amd64 Packages [4243 B]          
Fetched 17.5 MB in 18s (953 kB/s)                                                                  
Reading package lists... Done
```

- 提交副本
```docker
docker commint -n="描述信息" -a="镜像作者" 容器ID  镜像名

[root@diudiu ~]# docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
4a10d61a5a60        ubuntu:18.04        "/bin/sh -c 'while..."   50 seconds ago      Up 49 seconds                           elastic_chandrasekhar
[root@diudiu ~]# docker images
REPOSITORY              TAG                 IMAGE ID            CREATED             SIZE
diudiu/ubuntu           v2                  4b8bdd870f4c        11 seconds ago      64.2 MB
docker.io/ubuntu        18.04               ccc6e87d482b        12 days ago         64.2 MB
docker.io/hello-world   latest              fce289e99eb9        13 months ago       1.84 kB
```
可以查看到副本 diudiu/ubuntu


- 构建镜像 
创建Dockerfile文件，[具体介绍可参考这篇文章][1]

    [root@diudiu ~]# vim Dockerfile 
    [root@diudiu ~]# cat Dockerfile 
    FROM    centos:6.7
    MAINTAINER      Fisher "fisher@sudops.com"
    
    RUN     /bin/echo 'root:123456' |chpasswd
    RUN     useradd youj
    RUN     /bin/echo 'youj:123456' |chpasswd
    RUN     /bin/echo -e "LANG=\"en_US.UTF-8\"" &gt; /etc/default/local
    EXPOSE  22
    EXPOSE  80
    CMD     /usr/sbin/sshd -D


**docker bulid** 
-t 自定义镜像名
目录可以使用绝对目录

    [root@diudiu ~]# docker build -t diudiu/centos:6.7 /root/
    LANG="en_US.UTF-8"
    The command '/bin/sh -c /bin/echo -e "LANG=\"en_US.UTF-8\"" &gt; /etc/default/local' returned a non-zero code: 127
    [root@diudiu ~]# docker build -t diudiu/centos:6.7 /root/ |more
    Sending build context to Docker daemon 74.75 kB
    Step 1/9 : FROM centos:6.7
     ---> 9f1de3c6ad53
    Step 2/9 : MAINTAINER Fisher "fisher@sudops.com"
     ---> Using cache
     ---> 546e663ef9fa
    Step 3/9 : RUN /bin/echo 'root:123456' |chpasswd
     ---> Using cache
     ---> 4f2f3b3e5b48
    Step 4/9 : RUN useradd youj
     ---> Using cache
     ---> 1716c22d7c83
    Step 5/9 : RUN /bin/echo 'youj:123456' |chpasswd
     ---> Using cache
     ---> 93fe0abc37a0
    Step 6/9 : RUN /bin/echo -e "LANG=\"en_US.UTF-8\"" &gt; /etc/default/local
     ---> Running in 0ac66346117c

    [root@diudiu ~]# docker images
    REPOSITORY              TAG                 IMAGE ID            CREATED             SIZE
    <none>                  <none>              93fe0abc37a0        3 minutes ago       191 MB
    diudiu/ubuntu           v2                  4b8bdd870f4c        58 minutes ago      64.2 MB
    docker.io/ubuntu        18.04               ccc6e87d482b        12 days ago         64.2 MB
    docker.io/centos        6.7                 9f1de3c6ad53        10 months ago       191 MB
    docker.io/hello-world   latest              fce289e99eb9        13 months ago       1.84 kB


- 设置标签

    [root@diudiu ~]# docker images
    REPOSITORY                    TAG                 IMAGE ID            CREATED             SIZE
    <none>                        <none>              93fe0abc37a0        24 minutes ago      191 MB
    diudiu/ubuntu                 v2                  4b8bdd870f4c        About an hour ago   64.2 MB
    docker.io/ubuntu              18.04               ccc6e87d482b        12 days ago         64.2 MB
    docker.io/centos              6.7                 9f1de3c6ad53        10 months ago       191 MB
    docker.io/hello-world         latest              fce289e99eb9        13 months ago       1.84 kB
    docker.io/garland/butterfly   latest              7124fec6c7ef        3 years ago         385 MB
    [root@diudiu ~]# docker tag ccc6e87d482b diudiu/centos:dev
    [root@diudiu ~]# docker images
    REPOSITORY                    TAG                 IMAGE ID            CREATED             SIZE
    <none>                        <none>              93fe0abc37a0        27 minutes ago      191 MB
    diudiu/ubuntu                 v2                  4b8bdd870f4c        About an hour ago   64.2 MB
    diudiu/centos                 dev                 ccc6e87d482b        12 days ago         64.2 MB
    docker.io/ubuntu              18.04               ccc6e87d482b        12 days ago         64.2 MB
    docker.io/centos              6.7                 9f1de3c6ad53        10 months ago       191 MB
    docker.io/hello-world         latest              fce289e99eb9        13 months ago       1.84 kB
    docker.io/garland/butterfly   latest              7124fec6c7ef        3 years ago         385 MB



  [1]: https://www.jianshu.com/p/a701de415be5


