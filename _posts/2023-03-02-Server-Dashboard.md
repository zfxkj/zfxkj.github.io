---
layout: post
title: 服务器仪表盘
subtitle: "经测试暂支持windows系统和Debian系统"
category : [ubuntu,debian,windows]
tags : [ubuntu,debian,windows]
date:    2023-03-02
author:   "小张"
header-img: "https://tc.zfxkj.top/picgo/xiu.png"
description:  "ubuntu系统应该也是支持的"
---

# 目录
{: .no_toc}

* 目录
{:toc}

# 简介
本项目是基于[Pi Dashboard](https://github.com/nxez/pi-dashboard)进行修改后的版本。  
原程序是使用php作为后端进行的开发，并且只适配了树莓派，现在使用python3作为后端。  

## 已知问题
在windows系统中使用，python3不能直接获取cpu温度，需要借助其他辅助工具，为了程序的简洁就没有进行修复，而是直接将温度显示为0  

## 前端展示
![sl](https://tc.zfxkj.top/picgo/sl.png)

## 项目地址
[https://github.com/zfxkj/Server-Dashboard](https://github.com/zfxkj/Server-Dashboard)