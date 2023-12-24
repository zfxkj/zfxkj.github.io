---
layout: post
title: ubuntu 安装zsh和配置
subtitle: "zsh的安装"
category : [ubuntu,zsh]
tags : [ubuntu,zsh]
date:       2022-02-15
author:     "小张"
header-img: "/img/post/ubuntu-zsh-6de98cf1-3945-4aa4-ae8f-9bbe5445340a.png"
description:  "本文还含有一些zsh的配置。"
---

# 目录
{: .no_toc}

* 目录
{:toc}


## 安装zsh
``` txt
#命令1 更新源
sudo apt-get update
#命令2 安装zsh
sudo apt-get install zsh
```
出现下面的内容就代表安装完成了。
![zsh1-5c1dc411-c63c-472b-b864-0517e85c0929](/img/post/zsh1-5c1dc411-c63c-472b-b864-0517e85c0929.png)
然后切换shell到zsh
```txt
chsh -s /bin/zsh
```

## 安装oh-my-zsh
``` txt
sh -c "$(curl -fsSL https://gitee.com/zfx521/ohmyzsh/raw/master/tools/install.sh)"
```
下载 zsh-syntax-highlighting 语法高亮插件
``` txt
git clone https://gitee.com/zfx521/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh}/plugins/zsh-syntax-highlighting
```
下载 zsh-autosuggestions 自动提示插件
```txt
git clone https://gitee.com/zfx521/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh}/plugins/zsh-autosuggestions
```
## 配置文件
配置.zshrc文件
```txt
vim ~/.zshrc
#plugins为插件，ZSH_THEME为主题
```
```txt
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)
```
最后一步应用配置，只要修改了~/.zshrc文件都要运行一下下面的代码
```txt
source ~/.zshrc
```

## 主题
- passion 比较好看的主题
![zsh-passion-6c84854c-ace8-4746-8a42-2431ddee0db7](/img/post/zsh-passion-6c84854c-ace8-4746-8a42-2431ddee0db7.gif)
- typewritten 一个最小的 zsh 提示符
![zsh-typewritten-96a1c7b3-1f5b-46aa-81c7-c54c559da83a](/img/post/zsh-typewritten-96a1c7b3-1f5b-46aa-81c7-c54c559da83a.gif)
- robbyrussell
![zsh2-d3255e2a-f78b-4a0e-8205-29261b5b73f7](/img/post/zsh2-d3255e2a-f78b-4a0e-8205-29261b5b73f7.jpg)
- af-magic
![zsh3-cfaea2e2-cf29-468e-9bec-e6fc40936816](/img/post/zsh3-cfaea2e2-cf29-468e-9bec-e6fc40936816.jpg)
- agnoster
![zsh4-cd86cc26-26c4-4319-88b7-3e5e6be71037](/img/post/zsh4-cd86cc26-26c4-4319-88b7-3e5e6be71037.jpg)
想要查看更多的主题？ [更多主题](https://github.com/ohmyzsh/ohmyzsh/wiki/themes)

## 卸载zsh
```txt
uninstall_oh_my_zsh zsh
```
删除~/.oh-my-zsh的文件夹和.zshrc的文件，也可以不删除  
修改shell为默认的
```txt
chsh -s /bin/bash
```
应用默认配置
```txt
source ~/.bashrc
```