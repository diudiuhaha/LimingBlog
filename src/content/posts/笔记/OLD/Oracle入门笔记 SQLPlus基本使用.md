---
title: Oracle入门笔记 SQLPlus基本使用
published: 2020-11-16 00:24:00
tags:
  - Oracle
  - Oracle 12c
  - SQLPlus
category: 学习笔记
image: api
slug: oracle-sqlplus-basics
---

## 启动SQLPus
![image.png]( https://p.diudiudevil.com/2020/11/16/diudiudevil.com_e7c586f4b642f.png)

## 用户登录
### 本地管理员登录（如sys用户）：
```sql
sys/pwd as sysdba
```

无需验证密码
![image.png]( https://p.diudiudevil.com/2020/11/16/diudiudevil.com_5457fb9f4a59f.png)

### 网络用户登录（如system用户）
```sql
system/pwd 
```
![image.png]( https://p.diudiudevil.com/2020/11/16/diudiudevil.com_83f82a8418a87.png)

## 连接数据库
- 没有指定实例和数据库，连接的是默认数据库

默认数据库：
![image.png]( https://p.diudiudevil.com/2020/11/16/diudiudevil.com_4d849ab1898fd.png)

- 如果要连接指定的数据库
    - 用户名/密码 @SID
![image.png]( https://p.diudiudevil.com/2020/11/16/diudiudevil.com_10b7e80b9f6ee.png)


