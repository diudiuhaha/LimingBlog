---
title: Vultr 服务器密码忘记密码？？？
published: 2020-01-31 21:43:00
tags:
  - Vultr
  - 密码
  - linux
category: 问题处理
---

重启

改 `ro` 到 `rw init=/sysroot/bin/sh`

`Ctrl-X`

    chroot /sysroot
    passwd root
    reboot -f