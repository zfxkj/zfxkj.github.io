---
layout: post
title: ubuntu 20.04 安装MYSQL
subtitle: "MYSQL的安装"
category : [ubuntu,MYSQL]
tags : [ubuntu,MYSQL]
date:       2022-02-14
author:     "小张"
header-img: "/img/post/ubuntu-mysql.png"
description:  "本文还含有一些MYSQL的使用方法。"
---

# 目录
{: .no_toc}

* 目录
{:toc}


## 安装MYSQL
``` txt
#命令1 更新源
sudo apt-get update
#命令2 安装mysql服务
sudo apt-get install mysql-server
```
![picture](/img/post/mysql1.png)

## 初始化配置
``` txt
sudo mysql_secure_installation
```
``` txt
#1
VALIDATE PASSWORD PLUGIN can be used to test passwords...
Press y|Y for Yes, any other key for No: N (选择N ,不会进行密码的强校验)

#2
Please set the password for root here...
New password: (输入密码)
Re-enter new password: (重复输入)

#3
By default, a MySQL installation has an anonymous user,
allowing anyone to log into MySQL without having to have
a user account created for them...
Remove anonymous users? (Press y|Y for Yes, any other key for No) : N (选择N，不删除匿名用户)

#4
Normally, root should only be allowed to connect from
'localhost'. This ensures that someone cannot guess at
the root password from the network...
Disallow root login remotely? (Press y|Y for Yes, any other key for No) : N (选择N，允许root远程连接)

#5
By default, MySQL comes with a database named 'test' that
anyone can access...
Remove test database and access to it? (Press y|Y for Yes, any other key for No) : N (选择N，不删除test数据库)

#6
Reloading the privilege tables will ensure that all changes
made so far will take effect immediately.
Reload privilege tables now? (Press y|Y for Yes, any other key for No) : Y (选择Y，修改权限立即生效)
```
现在就初始化完成了。

## 查看状态
``` txt
systemctl status mysql 或 service mysql status
```
如果看到有一个绿色的点和几个绿色的单词就代表运行成功。就像这样的↓
![picture](/img/post/mysql2.png)

## 远程访问
在Ubuntu下MySQL是只允许本地访问的，使用workbench连接工具是连不上的，如果你要其他机器也能够访问的话，需要进行配置。
```txt
sudo vi /etc/mysql/mysql.conf.d/mysqld.cnf
#找到 bind-address 修改值为 0.0.0.0
sudo /etc/init.d/mysql restart
#重启mysql
```
进入数据库
```txt
sudo mysql -uroot -p
# 输入你的密码

use mysql;
#切换数据库
select User,authentication_string,Host from user;
#查询用户表命令
select host,user,plugin from user;
#查看状态

#设置权限与密码
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '密码';
#使用mysql_native_password修改加密规则
ALTER USER 'root'@'localhost' IDENTIFIED BY '密码' PASSWORD EXPIRE NEVER;
#更新一下用户的密码
UPDATE user SET host = '%' WHERE user = 'root';
#允许远程访问
flush privileges;
#刷新cache中配置 刷新权限
quit;
#退出
```
其中root@localhost，localhost就是本地访问，配置成 % 就是所有主机都可连接；第二个’密码’为你给新增权限用户设置的密码，%代表所有主机，也可以是具体的ip；注意不要直接更新密码的编码格式，而不加密码，这样会出现一些问题。

## 数据库命令
更改密码 ：mysqladmin -u用户名 -p旧密码 password 新密码
```txt
mysqladmin -uroot -proot password 123456 
```
选择数据库
```txt
use zfx;
#zfx为数据库名
```
修改数据库内数据表中的字段的属性
```txt
alter table wx modify column aad varchar(3000) default '0';
#wx为数据表名，aad为字段名，后面为属性
```
在数据表中新加入字段
```txt
alter table wx add column xx varchar(3000) default '0';
#wx为表名，xx为字段名，后面属性
```
查看所有数据库名
```txt
SHOW DATABASES;
```
查看数据库中的数据表名
```txt
SHOW TABLES;
#需要配合use使用
```
查看当前选择的数据库
```txt
select database();
```
删除数据表中的字段
```txt
ALTER TABLE wx DROP column xx;
#wx为表名，xx为字段名
```
删除数据库
```txt
drop database zfx;
#zfx为数据库名
```
删除数据表
```txt
DROP TABLE zfx;
#zfx为表名
```
创建数据库
```txt
CREATE DATABASE test_db;
#test_db为数据库名
```
创建数据表
```txt
CREATE TABLE zfx( id INT UNSIGNED AUTO_INCREMENT,id int(10) NOT NULL, title VARCHAR(100) NOT NULL, PRIMARY KEY (id) )ENGINE=InnoDB DEFAULT CHARSET=utf8;
#zfx为数据表名，id为自增值，id为字段名后面是属性，title为字段名后面是属性，设置id为主键
```
查看表结构
```txt
desc wx;
#wx为表名
```
更改表名称
```txt
rename table wx to wxa;
#wx为修改前的名称，wxa为修改后的名称
```
```txt
ALTER TABLE wxa AUTO_INCREMENT = 3;
#将 wxa表 自增 ID 重置为 3
```
MySQL的常用命令
```txt
insert into wx(user_name) values ('Michae');
#插入数据，在wx表中的user_name字段名下插入Michae
SELECT * FROM wx WHERE ID != 0";
#查询id不等于0的所有数据，并且不排序
SELECT * FROM wx WHERE ID != 0 ORDER BY 字段名;
#升序查询，字段名后加DESC为降序
UPDATE wx SET id = '123' WHERE user_id = '1';
#修改user_id为1的数据把里面的id改为123
DELETE FROM wx WHERE user_id = '1';
#删除user_id为1的记录
SELECT count(*) FROM wx WHERE id != 1;
#查询id不等于1的记录有几条
```

## 数据库的备份与恢复
本地备份：mysqldump -u用户名 -p'密码' 数据库名 > 导出的文件名
```txt
mysqldump -uroot -p'123456' wx > wx.sql
```
远程备份（用A服务器备份B服务器的数据）：mysqldump -h B数据库IP -u用户名 -p'密码' 数据库名 > 导出的文件名
```txt
mysqldump -h 192.168.1.2 -uroot -p'123456' wx > wx.sql
```
本地恢复：mysql -u用户名 -p'密码' 数据库名 < 数据文件的文件名
```txt
mysql -uroot -p'123456' wx < wx.sql
```
远程恢复（用A服务器恢复B服务器的数据）：mysql -h B数据库IP -u用户名 -p'密码' 数据库名 < 数据文件的文件名
```txt
mysql -h 192.168.1.2 -uroot -p'123456' wx < wx.sql
```

## 卸载MySQL
```txt
dpkg --list|grep mysql
sudo apt-get remove mysql-common
sudo apt-get autoremove --purge mysql-server
```
清理残留数据
```txt
dpkg -l |grep ^rc|awk '{print $2}' |sudo xargs dpkg -P
```
删除原先配置文件
```txt
sudo rm -rf /etc/mysql/ /var/lib/mysql
sudo apt autoremove
sudo apt autoreclean(如果提示指令有误，就把reclean改成clean)
```
## 免责声明
- 本文转自[CSDN](https://blog.csdn.net/weixin_38924500/article/details/106261971)的文章。
- 在原先的基础上进行了修改和删减。
- 如有侵权请联系删除。
