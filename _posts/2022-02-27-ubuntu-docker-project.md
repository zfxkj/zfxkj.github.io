---
layout: post
title: ubuntu docker项目
subtitle: "3个docker必备项目。"
category : [ubuntu,docker]
tags : [ubuntu,docker]
date:    2022-02-27
author:   "小张"
header-img: "/img/post/ubuntu_docker.png"
description:  "常用项目的搭建即使用。"
---

# 目录
{: .no_toc}

* 目录
{:toc}


# 温馨提示

下面的程序均用到了docker，如果还没有安装docker请点击下方链接查看docker的安装。

[ubuntu docker 安装](https://www.zfx521.top/blog/2022/02/27/Ubuntu-docker/)

# 1.Alist

## 1.1 项目展示

Github项目地址：[https://github.com/Xhofe/alist](https://github.com/Xhofe/alist)

Demo：[https://alist.nn.ci](https://alist.nn.ci)

Alist文档地址：[https://alist-doc.nn.ci/en/](https://alist-doc.nn.ci/en/)

![picture](/img/post/docker_alist.png)

## 1.2 项目搭建

演示搭建使用docker。

其中`-v`后面的路径`:`左边可以替换成自己的路径，和前面一样端口号也可以替换成自己的。

稳定版

```
docker run -d --restart=always -v ~/zfx/docker/pan:/opt/alist/data -p 5212:5244 --name="alist" xhofe/alist:latest
```

开发版

```
docker run -d --restart=always -v ~/zfx/docker/pan:/opt/alist/data -p 5212:5244 --name="alist" xhofe/alist:v2
```

查看初始密码

```
docker logs alist
# 或者
docker exec -it alist ./alist -password
```

至此项目搭建完成，可以在浏览器输入`http://你的ip:5212`就可以访问到了，如果上面的端口修改了，这里也要改成相应的端口。

## 1.3 更新Alist

```
docker stop alist  #停止alist容器

docker rm -f alist  #删除alist容器，因为之前映射到了本地，所以数据不会被删除

cp -r ~/zfx/docker/pan ~/zfx/docker/pan.bak  #可选，如果不放心，可以备份一下数据

docker pull xhofe/alist:latest  #拉取最新的alist镜像

docker run -d --restart=always -v ~/zfx/docker/pan:/opt/alist/data -p 5212:5244 --name="alist" xhofe/alist:latest    #运行安装命令，注意-v挂载的路径与原来相同

```

## 1.4 类似项目
filebrowers可以自行了解  

运行代码  
```shell
docker run -d --name pan --restart always \
    -v ~/zfx/docker/pan/pan:/srv \
    -v ~/zfx/docker/pan/filebrowser.db:/database/filebrowser.db \
    -v ~/zfx/docker/pan/settings.json:/config/settings.json \
    -e PUID=$(id -u) \
    -e PGID=$(id -g) \
    -p 5212:80 \
    filebrowser/filebrowser:latest
```

# 2.docker可视化面板

## 2.1 项目简介

Portainer是一个非常好用的Docker可视化面板，可以让你轻松地管理你的Docker容器。

官网：[https://www.portainer.io/](https://www.portainer.io/)

![picture](/img/post/docker_ui.png)

## 2.2 项目搭建

其中第二个`-v`后面的路径`:`左边可以替换成自己的路径，和前面一样端口号也可以替换成自己的。

### 2.2.1 英文版(官方)

```
docker run -d -p 8000:8000 -p 9000:9000 --name docker_webui \
    --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v ~/zfx/docker/docker_web_ui:/data \
    cr.portainer.io/portainer/portainer-ce:2.11.1
```

### 2.2.2 中文版(修改版)

x86一键安装代码

```
docker run -d --restart=always --name="portainer" -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data 6053537/portainer-ce
```

arm64一键安装代码

```
docker run -d --restart=always --name="portainer" -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data 6053537/portainer-ce:linux-arm64
```

至此项目搭建完成，可以在浏览器输入`http://你的ip:9000`就可以访问到了，如果上面的端口修改了，这里也要改成相应的端口。

## 2.3 更新面板

```
docker stop docker_webui  #停止可视化面板容器

docker rm -f docker_webui  #删除可视化面板容器，因为之前映射到了本地，所以数据不会被删除

docker pull cr.portainer.io/portainer/portainer-ce:2.11.1  #拉取最新的可视化面板镜像，修改版本号为最新版即可其中2.11.1即为版本号。重新运行上方项目搭建的代码，修改为刚才的版本号即可。
```

再次执行项目搭建的代码就可以运行了。

# 3.密码管理器

## 3.1 项目简介

Bitwarden 是一款开源密码管理器，它会将所有密码加密存储在服务器上，它的工作方式与 LastPass、1Password 或 Dashlane 相同。

官方的版本搭建对服务器要求很高，搭建不容易，GitHub上有人用 Rust 实现了 Bitwarden 服务器，项目叫 vaultwarden，并且提供了 Docker 镜像，这个实现更进一步降低了对机器配置的要求，并且 Docker 镜像体积很小，部署非常方便。这个项目目前在GitHub也有9.8k的star，非常受欢迎。

此外，官方服务器中需要付费订阅的一些功能，在这个实现中是免费的。

Github项目地址：[https://github.com/dani-garcia/vaultwarden](https://github.com/dani-garcia/vaultwarden)

![picture](/img/post/docker_password.png)

## 3.2 项目搭建

其中`-v`后面的路径`:`左边可以替换成自己的路径，和前面一样端口号也可以替换成自己的。

```
docker run -d --name bitwardenrs \
  --restart always \
  -e WEBSOCKET_ENABLED=true \
  -v ~/zfx/docker/passwd:/data/ \
  -p 6666:80 \
  -p 3012:3012 \
  vaultwarden/server:latest
```

现在程序已经搭建完成去浏览器访问`http://你的ip:6666`即可看到页面，先注册一个账号，现在是所有人都可以注册的状态，如果不想让其他人注册也很简单，继续往下看

```
docker stop bitwardenrs  #停止容器
docker rm -f bitwardenrs  #删除容器
```

重新执行下边的代码。（禁止用户注册代码）

```
docker run -d --name bitwardenrs \
  --restart always \
  -e SIGNUPS_ALLOWED=false \
  -e WEBSOCKET_ENABLED=true \
  -v ~/zfx/docker/passwd/:/data/ \
  -p 6666:80 \
  -p 3012:3012 \
  vaultwarden/server:latest
```

细心的人应该发现了就是在原来的内容中加入了`-e SIGNUPS_ALLOWED=false \`的代码，这样别人就不能注册了，你可以先自己注册一个账号，然后停止容器，在删除容器，重新执行上面的代码，就可以禁止别人注册了，而你刚才注册的账号是不会消失的。

## 3.3 更新密码管理器

```
docker stop bitwardenrs  #停止密码管理器容器

docker rm -f bitwardenrs  #删除密码管理器容器，因为之前映射到了本地，所以数据不会被删除

docker pull vaultwarden/server:latest  #拉取最新的可视化面板镜像，修改版本号为最新版即可其中2.11.1即为版本号。重新运行上方项目搭建的代码，修改为刚才的版本号即可。
```

再次执行项目搭建的代码就可以运行了。

# 免责声明

上面的程序来自[咕咕鸽](https://blog.laoda.de/)的文章

1. [【好玩的Docker项目】目前最好用的网盘直链程序——AList，支持市面上几乎所有网盘！可以代替Olaindex！](https://blog.laoda.de/archives/docker-install-alist)

2. [【Docker系列】Docker可视化面板——Portainer](https://blog.laoda.de/archives/portainer)

3. [【保姆级教程】利用宝塔面板+Docker搭建一个优秀的密码管理器——Bitwarden](https://blog.laoda.de/archives/bitwarden-docker-install)

4. [portainer-ce中文汉化版](https://hub.docker.com/r/6053537/portainer-ce)

这里做了简化处理，原作者文章内还有视频教程。

如有侵权请联系删除。

