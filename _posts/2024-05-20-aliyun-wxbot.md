---
layout: post
title: 阿里云盘自动签到
subtitle: "使用python实现阿里云盘自动签到"
category : [wxbot]
tags : [wxbot,阿里云盘]
date:       2024-05-20
author:     "小张"
header-img: "https://www.zfxkj.top/picgo/aliyun_top.png"
description:  "本文章介绍一些关于在公众号使用阿里云盘签到的方法。。。"
font-color: "#000000"
---

## 使用方法
### refresh_token获取
首先需要获取refresh_token，方法如下：  
[https://alist.nn.ci/guide/drivers/aliyundrive.html](https://alist.nn.ci/guide/drivers/aliyundrive.html)  
点击上面的链接，找到如下页面
![aliyun_refresh](https://www.zfxkj.top/picgo/aliyun_refresh.png)
点击`Get Token`，出现如下页面，手机阿里云盘扫码登录
![aliyun_scan_qr](https://www.zfxkj.top/picgo/aliyun_scan_qr.png)
扫码后点击`Use AliyunDrive APP To Scan Then Click`
![aliyun_scan_qr_success](https://www.zfxkj.top/picgo/aliyun_scan_qr_success.png)
复制下面的`Token`
![aliyun_refresh_token](https://www.zfxkj.top/picgo/aliyun_refresh_token.png)

### 登陆
在公众号内发送：`阿里云盘#登录#refresh_token`  
假设我的账号refresh_token为：`340xxxxe1`  
那我登录的消息应该为：`阿里云盘#登录#340xxxxe1`  
假设我的账号refresh_token为：`123aa`  
那我登录的消息应该为：`阿里云盘#登录#123aa`

![aliyun_login](https://www.zfxkj.top/picgo/aliyun_login.png)

登录不会验证账号refresh_token是否正确，请自行核对。  
只有签到时才会验证refresh_token是否正确。  

### 签到
签到消息为：`阿里云盘#签到`  

![aliyun_qd](https://www.zfxkj.top/picgo/aliyun_qd.png)

### 查看签到信息
签到时间为2分钟，签到结束后可以查看签到信息。  
查看签到信息的消息为：`阿里云盘#信息`  
自动推送消息可以回复：`15`

![aliyun_info](https://www.zfxkj.top/picgo/aliyun_info.png)

如果不想每天发送消息签到可以这样设置，  
每天自动签到：`阿里云盘#开`  
想关闭自动签到也很容易，  
关闭每天自动签到：`阿里云盘#关`  
想要退出登陆也很简单，  
发送消息：`阿里云盘#退出`  
建议绑定邮箱或者是server酱，这样签到信息会直接发送到邮箱或者server酱，  
绑定方式：`绑定#邮箱#邮箱地址`  
具体方式可以回复：15
  
## 注意事项
自动签到后不会有消息提醒，建议配合`绑定`使用  
上方含有`#`的地方`#`发送消息的时候必须带上`#`否则信息无效！！！  
登录消息只要没有修改密码或换绑手机号是不用每天发送的。  
点击`左上角`再点击`关于我`就会出现公众号二维码。

## 微信公众号
![微信公众号](https://www.zfxkj.top/picgo/微信公众号.jpg)