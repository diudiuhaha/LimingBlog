---
title: 解决Linux报错&quot;Another app is currently holding the yum lock; waiting for it to exit...&quot;的问题
published: 2019-04-26 12:20:00
tags:
  - linux
  - yum
category: 问题处理
image: api
slug: how-to-fix-yum-lock-error-another-app-holding-lock
---

在执行yum相关命令的时候，出现以下提示：

    Another app is currently holding the yum lock; waiting for it to exit...

而且，
 使用kill杀死不了占用yum的进程

可以采用以下命令：

    rm -f /var/run/yum.pid

重新执行yum命令，再无此提示并执行成功。
ok。
