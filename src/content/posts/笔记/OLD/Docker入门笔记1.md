---
title: Docker入门笔记1
published: 2020-01-27 20:43:00
tags:
  - docker
  - 入门笔记
category: 学习笔记
image: api
slug: docker-getting-started-part-1
---


# 前言

目前环境为centos7 64位

> \[root\@diudiu \~]# cat /proc/version
> Linux version 3.10.0-514.26.2.el7.x86\_64 (<builder@kbuilder.dev.centos.org>) (gcc version 4.8.5 20150623 (Red Hat 4.8.5-11) (GCC) ) #1 SMP Tue Jul 4 15:04:05 UTC 2017
> Docker版本为 1.13.1
> 主要参考W3C的相关课程
> [w3cschool](https://www.w3cschool.cn/docker/centos-docker-install.html)

## 安装与测试

    yum install docker -y

启动后台：

    [root@diudiu ~]# systemctl start docker

查看版本号

        [root@diudiu ~]# docker version
    Client:
     Version:         1.13.1
     API version:     1.26
     Package version: docker-1.13.1-103.git7f2769b.el7.centos.x86_64
     Go version:      go1.10.3
     Git commit:      7f2769b/1.13.1
     Built:           Sun Sep 15 14:06:47 2019
     OS/Arch:         linux/amd64

    Server:
     Version:         1.13.1
     API version:     1.26 (minimum version 1.12)
     Package version: docker-1.13.1-103.git7f2769b.el7.centos.x86_64
     Go version:      go1.10.3
     Git commit:      7f2769b/1.13.1
     Built:           Sun Sep 15 14:06:47 2019
     OS/Arch:         linux/amd64
     Experimental:    false

## 运行Docker 程序

### 拉取并运行hello-world

    [root@diudiu ~]# docker pull hello-world
    Using default tag: latest
    Trying to pull repository docker.io/library/hello-world ... 
    latest: Pulling from docker.io/library/hello-world
    Digest: sha256:9572f7cdcee8591948c2963463447a53466950b3fc15a247fcad1917ca215a2f
    Status: Image is up to date for docker.io/hello-world:latest
    [root@diudiu ~]# docker run hello-world
    container_linux.go:235: starting container process caused "process_linux.go:258: applying cgroup con
    figuration for process caused \"Cannot set property TasksAccounting, or unknown property.\""
    /usr/bin/docker-current: Error response from daemon: oci runtime error: container_linux.go:235: star
    ting container process caused "process_linux.go:258: applying cgroup configuration for process cause
    d \"Cannot set property TasksAccounting, or unknown property.\"".

***

可以发现是运行失败的。
寻求了一下度娘和谷哥的帮助，得到了解决的方案

    yum update

即可以解决了。

     [root@diudiu ~]# docker run hello-world

    Hello from Docker!
    This message shows that your installation appears to be working correctly.

    To generate this message, Docker took the following steps:
     1. The Docker client contacted the Docker daemon.
     2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
        (amd64)
     3. The Docker daemon created a new container from that image which runs the
        executable that produces the output you are currently reading.
     4. The Docker daemon streamed that output to the Docker client, which sent it
        to your terminal.

    To try something more ambitious, you can run an Ubuntu container with:
     $ docker run -it ubuntu bash

    Share images, automate workflows, and more with a free Docker ID:
     https://hub.docker.com/

    For more examples and ideas, visit:
     https://docs.docker.com/get-started/

## Docker的使用

### Docker Hello World

#### 使用 docker run 命令来在容器内运行一个应用程序

    docker run ubuntu:18.04 /bin/echo "Hello world"

*   docker: Docker 的二进制执行文件。
*   run:与前面的 docker 组合来运行一个容器。
*   ubuntu:18.04指定要运行的镜像，Docker首先从本地主机上查找镜像是否存在，如果不存在，Docker 就会从镜像仓库 Docker Hub 下载公共镜像。
*   /bin/echo "Hello world": 在启动的容器里执行的命令

输出：

    [root@diudiu ~]# docker run ubuntu:18.04 /bin/echo "Hello world"
    Unable to find image 'ubuntu:18.04' locally
    Trying to pull repository docker.io/library/ubuntu ... 
    18.04: Pulling from docker.io/library/ubuntu
    5c939e3a4d10: Pull complete 
    c63719cdbe7a: Pull complete 
    19a861ea6baf: Pull complete 
    651c9d2d6c4f: Pull complete 
    Digest: sha256:8d31dad0c58f552e890d68bbfb735588b6b820a46e459672d96e585871acc110
    Status: Downloaded newer image for docker.io/ubuntu:18.04
    Hello world

#### 运行交互的容器

这句话很好理解，就是进入容器的终端，

*   t:在新容器内指定一个伪终端或终端。
*   i:允许你对容器内的标准输入 (STDIN) 进行交互。

    \[root\@diudiu \~]# docker run -i -t ubuntu:18.04 /bin/bash
    root\@33d4c7c3f7be:/#

通过exit或者Ctrl D 退出

#### 启动容器（后台模式）

    [root@diudiu ~]# docker run -d ubuntu:18.04 /bin/sh -c "while true; do echo hello world; sleep 1; done"
    161723c789e4c225bf7a83962320a94743f81f8290d3b74ffd60a4614929380b

会输出容器ID，且为唯一的，

通过docker ps 确认是否有容器在运行
\[root\@diudiu \~]# docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED              STATUS\
PORTS               NAMES
161723c789e4        ubuntu:18.04        "/bin/sh -c 'while..."   About a minute ago   Up About a min
ute                       gracious\_kare

查看logs

    [root@diudiu ~]# docker logs 161723c789e4 
    hello world
    hello world
    hello world
    hello world
    hello world
    hello world
    hello world

或者： docker logs gracious\_kare

### 停止Docker

    docker stop 161723c789e4
    or
    docker stop gracious_kare

使用docker ps 查看状态
