---
title: 安装pip3遇到的坑，顺便安装you-get
published: 2019-05-02 18:51:00
tags:
  - python
  - pip
  - you-get
category: 问题处理
image: api
slug: pip3-you-get-installation-guide
---

## 前言 
最近想在电脑上安装[youget][2] ,发现需要pip安装，看了好几个博客教程全是旧的。找了很久突然发现官网是有教程的 。

` https://pip.pypa.io/en/stable/installing/`

## 步骤
也很简单

### 下载文件

    $curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
      % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                     Dload  Upload   Total   Spent    Left  Speed
    100 1669k  100 1669k    0     0   450k      0  0:00:03  0:00:03 --:--:--  449k

### python执行安装
这里要注意的是Python2好像不能用了，只能用3了，如果电脑里只有Python3则无视。

    $sudo python3 get-pip.py
    Collecting pip
      Downloading https://files.pythonhosted.org/packages/f9/fb/863012b13912709c13cf5cfdbfb304fa6c727659d6290438e1a88df9d848/pip-19.1-py2.py3-none-any.whl (1.4MB)
         |████████████████████████████████| 1.4MB 101kB/s 
    Collecting setuptools
      Downloading https://files.pythonhosted.org/packages/ec/51/f45cea425fd5cb0b0380f5b0f048ebc1da5b417e48d304838c02d6288a1e/setuptools-41.0.1-py2.py3-none-any.whl (575kB)
         |████████████████████████████████| 583kB 107kB/s 
    Collecting wheel
      Downloading https://files.pythonhosted.org/packages/96/ba/a4702cbb6a3a485239fbe9525443446203f00771af9ac000fa3ef2788201/wheel-0.33.1-py2.py3-none-any.whl
    Installing collected packages: pip, setuptools, wheel
    Successfully installed pip-19.1 setuptools-41.0.1 wheel-0.33.1

### 查看版本（检测）

    $pip3 --version
    pip 19.1 from /usr/local/lib/python3.6/dist-packages/pip (python 3.6)

则成功

### 安装you-get试试

    $sudo pip3 install you-get
    Collecting you-get
      Downloading https://files.pythonhosted.org/packages/dd/3e/fb3d8b4070ffdd55c108508f23f5ca2cbb41ec5f17f86b0f207dc1bd5f5b/you_get-0.4.1295-py3-none-any.whl (206kB)
         |████████████████████████████████| 215kB 315kB/s 
    Installing collected packages: you-get
    Successfully installed you-get-0.4.1295

解决！

[2]: https://github.com/soimort/you-get/
