---
title:  Linux学习笔记之搭建简单的nfs服务
published:  2020-01-27 20:43:00
tags: 
- linux
- nfs
category:  学习笔记
---

# NFS服务（network file system）
主要用于Linux之间的文件共享

## 前期准备
- 两台rhel虚拟机
  - 服务器1为服务端，IP为192.168.81.133/24
  - 服务器2为客户端，IP为192.168.81.134/24 
- 两个用来共享的目录，里面添加一些文件
  - 一个目录为只读共享  /nfs1
  - 一个目录为读写共享  /nfs2
- 服务器1上安装nfs-utils
  - yum install nfs-utils

# 配置
## 服务器1上的配置
### 修改配置文件
在/etc/exports中添加，格式为
本地目录路径 网段（参数）
具体参数为：
- ro      只读方式共享 
- rw     读写方式共享
- sync    同步
- async   异步 
- no_root_squash    所有用户访问均不匿名     
- root_squash       仅root用户访问时匿名（默认配置）
- all_squash        所有用户访问均匿名

（其文件默认为空）
例：

    [root@zero-one ~]# vim /etc/exports


    /nfs1 192.168.81.133/24(ro)
    /nfs2 192.168.81.134/24(rw)

### 防火墙放行（如果开了的话）

    # firewall-config 

在图形界面设置：
切换到permanent
勾选nfs服务
并重载防火墙服务
![防火墙设置.png][1]
### SELinux设置（如果开启的话）
#### 上下文
服务器共享目录的上下文设置为public_content_t
例如:

    [root@zero-one ~]# semanage fcontext -a -t public_content_t '/nfs1(/.*)?'
    [root@zero-one ~]# semanage fcontext -a -t public_content_t '/nfs2(/.*)?'

重载使生效

    [root@zero-one ~]# restorecon -RFv /nfs1
    restorecon reset /nfs1 context unconfined_u:object_r:default_t:s0->system_u:object_r:public_content_t:s0
    [root@zero-one ~]# restorecon -RFv /nfs2
    restorecon reset /nfs2 context unconfined_u:object_r:default_t:s0->system_u:object_r:public_content_t:s0

#### 布尔值

    [root@zero-one ~]# setsebool -P nfs_export_all_ro
    
    Usage:  setsebool [ -NPV ] boolean value | bool1=val1 bool2=val2...
    
    [root@zero-one ~]# setsebool -P nfs_export_all_rw
    
    Usage:  setsebool [ -NPV ] boolean value | bool1=val1 bool2=val2...

重载nfs服务使其生效

    [root@zero-one ~]# systemctl restart nfs-server.service 

设置nfs服务开机自启

    [root@zero-one ~]# systemctl enable nfs-server.service 

检测当前nfs共享
[root@zero-one ~]# exportfs -arv
exporting 192.168.81.134/24:/nfs2
exporting 192.168.81.133/24:/nfs1

## 设置服务器2 
Linux通过挂载的方式访问共享目录
### 临时挂载
新建一个挂载点，
mount ip：目录 挂载点
例子：

    [root@zero-two ~]# mkdir /home/gua1
    [root@zero-two ~]# mount 192.168.81.133:/nfs1 /home/gua1
    [root@zero-two ~]# ls /home/gua1
    1  2  3  4  5  6

    [root@zero-two ~]# mkdir /home/gua2
    [root@zero-two ~]# mount 192.168.81.133:/nfs2 /home/gua2
    [root@zero-two ~]# ls /home/gua2
    1  2  3  4  5  6  7

### 永久挂载
写在配置文件中：/etc/fstab
ip地址:路径   挂载点   nfs     defaults     0    0


## 其他
### 检测
检测挂载中文件的ro，rw属性
这里不多赘述