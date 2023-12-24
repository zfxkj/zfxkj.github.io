---
layout: post
title: Python flask 搭建基本网页
subtitle: "flask搭建网页"
category : [Python]
tags : [Python,flask]
date:       2021-11-27
author:     "小张"
header-img: "/img/post/python-b225f926-8351-4a8c-96a3-3478f1f0bd00.jpg"
description:  "用flask框架搭建一个简单的网页。"
---

## 项目目录
```txt
flask
├── static
│    ├── css
│    │    └── all.css
│    └── js
│         └── all.js
├── templates
│    └── index.html
├── app.py
└──bzm.py
```

## 项目简介
本项目仅仅实现了简单的用flask框架搭建网页，爬取网络上的图片并展示在网页上。  
其中`static`存放的是样式文件和网页脚本，`templates`中存放的是网页源文件，`app.py`为项目启动脚本，也是项目中最为关键的脚本，`bam.py`此文件为爬取网络图片的脚本。  

## 项目环境
首先要安装环境，本次安装以Ubuntu系统为例。  
更新软件：`sudo apt-get update & sudo apt-get upgrade`  
安装Python3：`sudo apt-get install python3`  
安装pip：`sudo apt-get install python3-pip`  
继续安装flask：`sudo pip3 install flask`  

## 项目运行
用`cd`进入flask目录输入`python3 app.py`就可以运行项目了，在浏览器输入`127.0.0.1:5000`就能看到页面了。  
如果你的能力出众还可以进行2次开发，使界面更美观。  

## 项目源码
all.css
```css
  .all {
    width: 100%;
  }
  .top_menu {
    height: auto;
    width: 100%;
    background-color: lightblue;
  }
  .db {
    height: auto;
    width: 100%;
  }
  .top_menu ul {
    list-style: none;
    height: 70px;
  }
  .top_menu ul li {
    float: left;
    text-align: center;
    width: 110px;
    height: 60px;
    font-size: 30px;
    line-height: 50px;
    color: cornflowerblue;
  }
  .db ul {
    list-style: none;
    height: 50px;
  }
  .db ul li {
    float: left;
    text-align: center;
    width: 33%;
    height: 50px;
    font-size: 35px;
    line-height: 50px;
    color: aqua;
  }
  button {
    position: absolute;
    right: 0px;
    top: 25px;
    margin: auto;
    border-width: 0px; /* 边框宽度 */
    border-radius: 3px; /* 边框半径 */
    background: #faf61c; /* 背景颜色 */
    cursor: pointer; /* 鼠标移入按钮范围时出现手势 */
    outline: none; /* 不显示轮廓线 */
    font-family: Microsoft YaHei; /* 设置字体 */
    color: rgb(58, 158, 252); /* 字体颜色 */
    font-size: 25px; /* 字体大小 */
  }
  button:hover { /* 鼠标移入按钮范围时改变颜色 */
	background: #f79999;
  }
  li:hover { /* 鼠标移入按钮范围时改变颜色 */
  background: #f79999;
  }
  a:link {text-decoration:none;}
  a:visited {text-decoration:none;}
  a:hover {text-decoration:underline;}
  a:active {text-decoration:underline;}
  a:link {color: rgb(58, 158, 252);}      /* 未访问链接*/
  a:visited {color: rgb(58, 158, 252);}  /* 已访问链接 */
  a:hover {color: rgb(58, 158, 252);}  /* 鼠标移动到链接上 */
  a:active {color: rgb(58, 158, 252);}  /* 鼠标点击时 */
  #table {
    float: left;
  }
```
all.js
```javascript
function up1(){
    var url;
    url = window.location.href;
    var a = url.substr(url.lastIndexOf("=") + 1);
    var aa = url.substr(url.lastIndexOf("&") + 1);
    var sum1 = Number(a);
    if (sum1==0)
    {
        alert("当前已是第一页了！");
    }
    else
    {
        var sum2 = sum1 - 1;
        var b = sum2.toString();
        var bb = "kip=" + b;
        var url1 = url.replace(aa,bb);
        window.location.href = url1
    }
}

function down1(){
    var url;
    url = window.location.href;
    var a = url.substr(url.lastIndexOf("=") + 1);
    var aa = url.substr(url.lastIndexOf("&") + 1);
    var sum1 = Number(a);
    var sum2 = sum1 + 1;
    var b = sum2.toString();
    var bb = "kip=" + b;
    var url1 = url.replace(aa,bb);
    window.location.href = url1
}
```
index.html
```html
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>图图站</title>
<link rel="shortcut icon" href="https://zfx521.gitee.io/img/favicon.ico" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="{{ url_for('static',filename='css/all.css') }}">
</head>
<body>
<div class="all">
  <h1>用户ID：{{ user }}</h1>
  <div class="top_menu">
    <ul>
      <a href="/?ym=1&kip=0"><li>推荐</li></a>
      <a href="/?ym=2&kip=0"><li>最新</li></a>
      <a href="/?ym=3&kip=0"><li>美女</li></a>
      <a href="/?ym=4&kip=0"><li>动漫</li></a>
      <a href="/?ym=5&kip=0"><li>风景</li></a>
      <a href="/?ym=6&kip=0"><li>游戏</li></a>
      <a href="/?ym=7&kip=0"><li>文字</li></a>
      <a href="/?ym=8&kip=0"><li>视觉</li></a>
      <a href="/?ym=9&kip=0"><li>情感</li></a>
      <a href="/?ym=10&kip=0"><li>设计</li></a>
      <a href="/?ym=11&kip=0"><li>明星</li></a>
      <a href="/?ym=12&kip=0"><li>物语</li></a>
      <a href="/?ym=13&kip=0"><li>男人</li></a>
      <a href="/?ym=14&kip=0"><li>机械</li></a>
      <a href="/?ym=15&kip=0"><li>城市</li></a>
      <a href="/?ym=16&kip=0"><li>动物</li></a>
    </ul>
  </div>
  <button><a href="/">退出</a></button>
  <div class="jpg">
    <table border="0">
    {% for img_jpg in list_jpg %}
        <tr>
          <td><a href="{{ img_jpg[0] }}"><img src="{{ img_jpg[0] }}" width="100%"></a></td>
          <td><a href="{{ img_jpg[1] }}"><img src="{{ img_jpg[1] }}" width="100%"></a></td>
          <td><a href="{{ img_jpg[2] }}"><img src="{{ img_jpg[2] }}" width="100%"></a></td>
          <td><a href="{{ img_jpg[3] }}"><img src="{{ img_jpg[3] }}" width="100%"></a></td>
        </tr>
    {% endfor %}
    </table>
  </div>
  <div class="db">
    <script src="{{ url_for('static',filename='js/all.js') }}"></script>
    <ul>
      <li onclick="up1()">上一页</li>
      <li>{{ ymk }}</li>
      <li onclick="down1()">下一页</li>
    </ul>
  </div>
</div>
</body>
</html>
```
app.py
```python
from flask import Flask, request, render_template
from bzm import start

app = Flask(__name__)


@app.route('/',methods=['GET','POST'])
def index():
    if request.args.get('ym'):
        ym = request.args.get('ym')
    else:
        ym = "1"
    if request.args.get('kip'):
        kip = request.args.get('kip')
    else:
        kip = 0
    if request.args.get('qs'):
        qs = request.args.get('qs')
    else:
        qs = None
    try:
        ex = start(ym,kip,qs)
    except:
        ex= ["图集加载失败"]
    ymk = "当前页面：" + str(kip)
    return render_template('index.html',user="test",list_jpg=ex,ymk=ymk)



if __name__ == "__main__":
    app.run(host='0.0.0.0',debug=True,port=5002)

```
bzm.py
```python
import requests, json, sys, time, os

url_template = "http://service.picasso.adesk.com:80/v1/vertical/{}vertical?{}limit=16&skip={}&adult=false&first=1&url=http%3A%2F%2Fservice.picasso.adesk.com%2Fv1%2Fvertical%2F{}vertical&order={}"

order='new'
skip = [0 for x in range(17)]
med_url = []
category_dict = {
    '1':["推荐", '','disorder=true&',skip[0],'','hot'],
    '2':["最新", '','',skip[0],'',order],
    '3':["美女", 'category/4e4d610cdf714d2966000000/','',skip[0],'category%2F4e4d610cdf714d2966000000%2F',order],
    '4':["动漫", 'category/4e4d610cdf714d2966000003/','',skip[0],'category%2F4e4d610cdf714d2966000003%2F',order],
    '5':["风景", 'category/4e4d610cdf714d2966000002/','',skip[0],'category%2F4e4d610cdf714d2966000002%2F',order],
    '6':["游戏", 'category/4e4d610cdf714d2966000007/','',skip[0],'category%2F4e4d610cdf714d2966000007%2F',order],
    '7':["文字", 'category/5109e04e48d5b9364ae9ac45/','',skip[0],'category%2F5109e04e48d5b9364ae9ac45%2F',order],
    '8':["视觉", 'category/4fb479f75ba1c65561000027/','',skip[0],'category%2F4fb479f75ba1c65561000027%2F',order],
    '9':["情感", 'category/4ef0a35c0569795756000000/','',skip[0],'category%2F4ef0a35c0569795756000000%2F',order],
    '10':["设计", 'category/4fb47a195ba1c60ca5000222/','',skip[0],'category%2F4fb47a195ba1c60ca5000222%2F',order],
    '11':["明星", 'category/5109e05248d5b9368bb559dc/','',skip[0],'category%2F5109e05248d5b9368bb559dc%2F',order],
    '12':["物语", 'category/4fb47a465ba1c65561000028/','',skip[0],'category%2F4fb47a465ba1c65561000028%2F',order],
    '13':["男人", 'category/4e4d610cdf714d2966000006/','',skip[0],'category%2F4e4d610cdf714d2966000006%2F',order],
    '14':["机械", 'category/4e4d610cdf714d2966000005/','',skip[0],'category%2F4e4d610cdf714d2966000005%2F',order],
    '15':["城市", 'category/4fb47a305ba1c60ca5000223/','',skip[0],'category%2F4fb47a305ba1c60ca5000223%2F',order],
    '16':["动物", 'category/4e4d610cdf714d2966000001/','',skip[0],'category%2F4e4d610cdf714d2966000001%2F',order]
}

def xh(url, qs):
    headers = {
        'User-Agent': 'Mozilla/5.0 (X11; Linux armv7l) AppleWebKit/537.36 (KHTML, like Gecko) Raspbian Chromium/74.0.3729.157 Chrome/74.0.3729.157 Safari/537.36'
    }
    qq = requests.get(url, headers=headers).text
    qq1 = json.loads(qq)
    qq2 = qq1.get("res").get("vertical")
    q = []
    list2 = []
    ff = 0
    if qs == None:
        for a in qq2:
            if ff == 0:
                list2.append(a.get("img"))
                ff = ff + 1
            elif ff == 1:
                list2.append(a.get("img"))
                ff = ff + 1
            elif ff == 2:
                list2.append(a.get("img"))
                ff = ff + 1
            elif ff == 3:
                list2.append(a.get("img"))
                ff = ff + 1
            else:
                ff = 0
                q.append(list2)
                list2 = []
    else:
        for a in qq2:
            q.append(a.get("img"))
    return q


def start(ym,kip,qs):
    display= ''
    for i in range(1,17):
        display = display + '{}={},'.format(str(i), category_dict[str(i)][0])
    display = display[:-1]
    item = category_dict[str(ym)]
    item[3] = int(kip) * 16
    url = url_template.format(item[1], item[2], item[3], item[4], item[5])
    txt = xh(url, qs)
    return txt

```

## 项目声明
本项目搭建好后站内图片来自网络，与本人无关，如有侵权请联系删除。
