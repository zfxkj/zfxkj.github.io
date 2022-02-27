---
layout: post
title: ubuntu ddns 使用
subtitle: "ddns 支持ipv4和ipv6 python脚本"
category : [ubuntu,ddns]
tags : [ubuntu]
date:    2022-02-27
author:   "小张"
header-img: "/img/post/ubuntu_ddns.png"
description:  "腾讯云域名官方文档实现ddns脚本。"
---

# 目录
{: .no_toc}

* 目录
{:toc}


# 1. DDNS简介

DDNS是动态域名服务（Dynamic Domain Name Server）的缩写，可以实现固定域名到动态IP地址之间的解析。 通常情况下，用户每次连接因特网时都会从ISP得到一个动态IP地址，即用户每次连接因特网得到的IP地址都不同。

# 2. 前期准备

首先你要有一个腾讯云的域名，进入腾讯云的DNSPOD然后点击右上角头像选择`api秘钥`进入后点击`腾讯云api秘钥`在点击`新建秘钥`

![img](img/post/ddns_1.png)


新建完成后会有2个参数，一个是`SecretId`另一个是`SecretKey`，我们吧这两个参数记下来。

![img](img/post/ddns_2.png)


然后去域名解析那里解析一个域名，如果用ipv6的地址就设置解析记录类型为`AAAA`，先随便填写一个记录值（简单点的记录值，fe80::ac34）,ipv4同理
最后来安装腾讯云的Python包

```shell
pip install -i https://mirrors.tencent.com/pypi/simple/ --upgrade tencentcloud-sdk-python
```

至此准备工作完成。

# 3. 源码展示

## 3.1 ddns.py

```python
import json,os,requests,sys,netifaces,time
#from gmail import email
from tencentcloud.common import credential
from tencentcloud.common.profile.client_profile import ClientProfile
from tencentcloud.common.profile.http_profile import HttpProfile
from tencentcloud.common.exception.tencent_cloud_sdk_exception import TencentCloudSDKException
from tencentcloud.dnspod.v20210323 import dnspod_client, models
def start(ym,jlz):
    try:
        cred = credential.Credential("这里填写上面获取得SecretId", "这里填写SecretKey")
        httpProfile = HttpProfile()
        httpProfile.endpoint = "dnspod.tencentcloudapi.com"
        clientProfile = ClientProfile()
        clientProfile.httpProfile = httpProfile
        client = dnspod_client.DnspodClient(cred, "", clientProfile)
        req = models.DescribeRecordListRequest()
        params = {
            "Domain": ym,
            "Subdomain": jlz
        }
        req.from_json_string(json.dumps(params))
        resp = client.DescribeRecordList(req).to_json_string()
        resp = json.loads(resp)
        recordlist = resp["RecordList"]
        for record in recordlist:
            recordid = record['RecordId']
        return recordid
    except TencentCloudSDKException as err:
        print(err)
        #email("DDNS", str(err))
        sys.exit()
 
def fast(ym,jlz,type1):
    try:
        recordid = int(start(ym,jlz))
        if type1 == "AAAA":
            ip = netifaces.ifaddresses('eth0')[netifaces.AF_INET6][0]['addr'].replace("%eth0","")
        elif type1 == "A":
            ip = requests.get("http://members.3322.org/dyndns/getip").text
        else:
            print("程序不支持其他记录类型，只支持AAAA和A")
            sys.exit()
        cred = credential.Credential("这里填写上面获取得SecretId", "这里填写SecretKey")
        httpProfile = HttpProfile()
        httpProfile.endpoint = "dnspod.tencentcloudapi.com"
        clientProfile = ClientProfile()
        clientProfile.httpProfile = httpProfile
        client = dnspod_client.DnspodClient(cred, "", clientProfile)
        req = models.ModifyRecordRequest()
        params = {
            "Domain": ym,
            "SubDomain": jlz,
            "RecordType": type1,
            "RecordLine": "默认",
            "Value": ip,
            "RecordId": recordid
        }
        req.from_json_string(json.dumps(params))
        resp = client.ModifyRecord(req).to_json_string()
        localtime = time.asctime(time.localtime(time.time()))
        print(localtime,resp)
    except TencentCloudSDKException as err:
        print(localtime,err)
        #email("DDNS", str(err))
 
fil = sys.argv[1]
with open(fil,"r") as f:
    data = f.read()
data = json.loads(data)
for over in data:
    ym = over["域名"]
    jlz = over["主机记录"]
    type1 = over["记录类型"]
    fast(ym,jlz,type1)
print("结束")
```

## 3.2 ddns.conf

```text
[
    {"域名":"zfx.top","主机记录":"wxllha","记录类型":"AAAA"},
    {"域名":"zfx.top","主机记录":"gfiker","记录类型":"A"}
]
```



# 4. 注意事项

然后就可以使用了，运行方式Python3 ddns.py ddns.conf
由于腾讯云限制，访问速度不能超过20次/秒
再设置一下自动执行
如果你是在将2个文件都放在了home目录的用户名下

```text
*/6 * * * * python3 ~/ddns.py ~/ddns.conf
```

上面的意思是每隔6分钟执行一次，至此完成。
