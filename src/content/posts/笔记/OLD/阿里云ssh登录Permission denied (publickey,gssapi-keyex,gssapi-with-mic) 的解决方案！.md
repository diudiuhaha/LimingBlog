---
title: 阿里云ssh登录Permission denied (publickey,gssapi-keyex,gssapi-with-mic) 的解决方案！
published: 2019-04-26 12:20:00
tags:
  - linux
  - 阿里云
  - ssh
category: 问题处理
image: api
---


今天远程登陆阿里云主机突然登不上去了，
报错如下
`Permission denied (publickey,gssapi-keyex,gssapi-with-mic)`

查看[官方文档][2]得知，

**启用密钥之后，服务器会自动禁止使用root账号密码登录。**

使用官方的网页版远程连接，
登陆并修改修改`/etc/ssh/sshd_config`文件中的`PasswordAuthentication no`改为`PasswordAuthentication yes`并保存。
重启`ssh`服务，即可，

    sudo systemctl restart sshd

解决。

[2]: https://help.aliyun.com/document_detail/59083.html?spm=5176.10173289.107.1.5aeb2e77ORGyqM#windows