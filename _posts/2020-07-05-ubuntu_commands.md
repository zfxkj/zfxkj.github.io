---
layout: post
title: Ubuntu系统的常用命令
subtitle: "介绍Ubuntu系统下经常用到的功能"
category : [Ubuntu]
tags : [Ubuntu]
date:       2020-07-05 12:30:04 +08:00
author:     "晨曦"
header-img: "/img/post/ubuntu-canonical-bg.png"
description:  "主要是用户管理、远程访问等命令，基本不包括文件系统的常用命令"
---
  
# 目录
{: .no_toc}

* 目录
{:toc}

## 1. ubuntu桌面版安装ssh
桌面版本的Ubuntu linux系统，默认没有安装ssh服务，可以通过如下命令开启ssh服务：  
```bash
# 安装openssh，如果安装完成，服务默认已经开启，即可远程ssh连接
sudo apt-get install openssh-server
# 查看ssh服务状态
sudo service ssh status
# ssh服务重启命令
sudo service ssh restart
# 编辑ssh服务的配置文件，可以修改服务端口，权限控制等
sudo vim /etc/ssh/sshd_config
```
ssh的配置文件`sshd_config`主要参数说明如下：  
```conf
# 这个是ssh服务的监听端口，在实际生产环境中一般都不用默认的22端口 
Port 22
# AddressFamily 设置为any：默认ipv4和ipv6地址均可连接
AddressFamily any
# ListenAddress 用来设置sshd服务器绑定的IP地址
# ListenAddress 192.168.0.231   表示只监听来自192.168.0.231这个IP的SSH连接
# ListenAddress 0.0.0.0         表示监听所有IPv4的SSH连接
# ListenAddress ::              表示监听所有IPv6的SSH连接
# PermitRootLogin 设置root用户是否运行登录以及登录方式
PermitRootLogin no
# LoginGraceTime 宽限登录时间不输入密码两分钟自动退出
LoginGraceTime 2m
# AllowUsers 只允许特定的一些用户登录（root用户是否可登录要根据PermitRootLogin决定）
# AllowUsers myusername
# 优先级最高，禁止某些用户登录
# DenyUsers  name1
# 允许登陆的用户组
# AllowGroups mygroupname
# 禁止登录的用户组
# DenyGroups groupname1
# 设置sshd是否在用户登录时显示/etc/motd中的信息，可以在其中加入欢迎信息
PrintMotd no
# 是否在ssh登录成功后，显示上次登录信息
PrintLastLog yes
# ssh的服务端会传送KeepAlive的讯息给客户端，以确保两者的联机正常
# 这种消息可以检测到死连接、连接不当关闭、客户端崩溃等异常
# 任何一端死掉后，ssh可以立刻知道，而不会有僵尸程序的发生
TCPKeepAlive yes
```
具体对于`PermitRootLogin`选项来说，它可以设置为以下几个值（其中`without-password`也写为`prohibit-password`），且对于含义如下表：  

参数类别|是否允许ssh登陆|登录方式|交互shell|  
:--:|:--:|:--:|:--:|  
yes|允许|没有限制|没有限制|  
without-password|允许|除密码以外|没有限制|  
forced-commands-only|允许|仅允许使用密钥|仅允许已授权的命令|  
no|不允许|N/A|N/A|  

## 2. SSH保活的几种方法
### 2.1 配置服务器端
SSH总是被强行中断，导致效率低下，可以在服务端配置，让server每隔30秒向client发送一个keep-alive包来保持连接：`sudo vim /etc/ssh/sshd_config`
添加以下内容：  
```conf
ClientAliveInterval 30
ClientAliveCountMax 60
```
然后重启本地ssh：`sudo service ssh restart`  
第一行配置让server每隔30秒向client发送一个keep-alive包来保持连接；第二行配置表示如果连续发送keep-alive包数量达到60次，客户端依然没有反应，则服务端sshd断开连接。如果什么都不操作，该配置可以让连接保持30s*60，即30分钟  

### 2.2 配置客户端
如果服务端没有权限配置，或者无法配置，可以配置客户端ssh，使客户端发起的所有会话都保持连接：`sudo vim /etc/ssh/ssh_config`
添加以下内容：  
```conf
ServerAliveInterval 30
ServerAliveCountMax 60
```
然后重启本地ssh：`sudo service ssh restart`  
本地ssh每隔30s向server端sshd发送keep-alive包，如果连续发送60次，server仍然无回应断开连接
### 2.3 共享ssh连接
如果需要在多个窗口中打开同一个服务器连接，可以尝试添加`~/.ssh/config`，添加以下两行：  
```conf
ControlMaster auto
ControlPath ~/.ssh/connection-%r@%h:%p
```
然后重启本地ssh：`sudo service ssh restart`  
配置之后，第二条连接共享第一次建立的连接，加快速度  
如果希望每次SSH连接建立之后，此条连接会被保持4小时，退出服务器之后依然可以重用，则需要设置：  
`ControlPersist 4h`  
最终，一个示例`~/.ssh/config`文件配置如下:  
```conf
Host *
	ServerAliveInterval 3
	ServerAliveCountMax 20
	TCPKeepAlive no
	ControlMaster auto
	ControlPath ~/.ssh/connection-%r@%h:%p
	ControlPersist 4h
    User zfb
```
### 2.4 ssh连接的同时保活
`ssh -o ServerAliveInterval=60 user@sshserver`
## 3. Ubuntu用户管理
### 3.1 创建用户
创建用户，同时创建该用户主目录、创建用户同名的组（用户名为`username`）  
`sudo adduser username`  
会提示设置密码，其他提示回车即可  
如果需要让此用户有`root`权限，在`root`用户下修改`/etc/sudoers`文件：  
`root@ubuntu:~# sudo vim /etc/sudoers`  
修改文件如下：  
```conf
# User privilege specification
root ALL=(ALL) ALL
username ALL=(ALL) ALL
```
保存退出，`username`用户就拥有了`root`权限  
### 3.2 切换用户
从当前用户切换到`username`用户的命令：`su username`  
从普通用户切换到`root`用户还可以使用命令：`sudo su`  
在切换用户时，如果想在切换用户之后使用新用户的工作环境，可以在`su`和`username`之间加`-`，例如：`su - root`  
终端的提示符`$`表示普通用户；`#`表示超级用户，即`root`用户  
在终端输入`exit`或`logout`或使用快捷方式`Ctrl+d`，可以**退回到原来用户**  
### 3.3 修改用户密码
修改用户名为`username`的开机登录密码：`sudo passwd username`  
修改root密码（默认root无密码，第一次执行时创建密码）：`sudo passwd root`  
### 3.4 禁用和启用root登录
只是禁用`root`，但是`root`密码还保存着：
`sudo passwd -l root`  
再使用`su root`切换`root`用户发现认证失败  
启用root登录：  
`sudo passwd -u root`  
## 4. 查看当前活跃的用户
查看所有用户列表  
`cat /etc/passwd|grep -v nologin|grep -v halt|grep -v shutdown|awk -F":" '{ print $1"|"$3"|"$4 }'|more`  
查看当前登录的用户  
`w`  
查看自己登录的用户名  
`whoami`  
## 5. 查看当前占据内存最多的进程信息
将命令组合重命名写入`.bashrc`文件中方便使用：首先`vi ~/.bashrc`，然后将以下内容写入文件末尾  
```bash
alias maxmem="ps -aux|head -1;ps -aux | sort -k4nr | head "
# ps -aux会显示all进程、userid、x指代所有程序
# ps -aux|head -1表示只保留删除结果的第一行，也就是表头
# sort -k4nr命令：r表示是结果倒序排列，n为以数字大小排序
# -k4则是针对第4列的内容进行排序
# maxmem -4表示显示4条结果
```