---
layout: post
title: python 字符串基础使用
subtitle: "包含各类字符串的基础的使用"
category : [Python]
tags : [Python,字符串]
date:       2021-11-19
author:     "小张"
header-img: "/img/post/python-str.jpg"
description:  "由于多数关于字符串的使用无法全部记住所以写进博客！！！"
---

## 分割字符串
```python
txt = "welcome to China"
x = txt.split()
print(x)
# ["welcome","to","China"]

txt = "hello, my name is Bill, I am 63 years old"
x = txt.split(", ")
print(x)
# ["hello","my name is Bill","I am 63 years old"]
```
string.split(separator, max)  
separator：可选。规定分割字符串时要使用的分隔符。默认值为空白字符(空格)。  
max：可选。规定要执行的拆分数。默认值为 -1，即“所有出现次数”。  
注意：分割后变成列表的形式  

## 替换字符串
```python
txt = "I like bananas"
x = txt.replace("bananas", "apples")
print(x)
# I like apples
```
string.replace(oldvalue, newvalue, count)  
oldvalue：必需。需要替换的字符串。  
newvalue：必需。替换成为的字符串。  
count：可选。数字，指定要替换的旧值出现次数。默认为所有的出现。  

```python
import re
s = 'aaa@xxx.com bbb@yyy.com ccc@zzz.com'
print(re.sub('[a-z]*@', 'ABC@', s))
# ABC@xxx.com ABC@yyy.com ABC@zzz.com
```
上面是用正则表达式`re.sub`的方式来替换字符串的，当然还有`re.subn`的替换方式这里就不过多解释，如果有需要可以自行了解。  

## 判断字符串长度
```python
str = "zfx123"
print(len(str))
# 6
```
len(str)  
str：必需。需要判断的字符串  
注意：空格和回车（换行符）各算一个字符！  

## 字符串判断
```python
str = "12345"
if str.isdigit(): # 判断str是否全为数字
# True
```
str为字符串  
str.isalnum() 所有字符都是数字或者字母  
str.isalpha() 所有字符都是字母  
str.isdigit() 所有字符都是数字  
str.islower() 所有字符都是小写  
str.isupper() 所有字符都是大写  
str.istitle() 所有单词都是首字母大写，像标题  
str.isspace() 所有字符都是空白字符、\t、\n、\r  
判断是否为数字或字母也可以用正则表达式。  

## 字符串格式化
```python
str = "My name is %s and weight is %d kg!" % ('Zara', 21)
print(str)
print('{0}和{1}是好朋友！'.format('张三', '李四'))
print('{0}和{1}是好朋友！'.format('张三', '李四'))
# My name is Zara and weight is 21 kg!
# 张三和李四是好朋友！
# 李四和张三是好朋友！
```
%c：格式化字符及其ASCII码  
%s：格式化字符串  
%d：格式化整数  
%u：格式化无符号整型  
%o：格式化无符号八进制数  
%x：格式化无符号十六进制数  
%X：格式化无符号十六进制数（大写）  
%f：格式化浮点数字，可指定小数点后的精度  
%e：用科学计数法格式化浮点数  
%E：作用同%e，用科学计数法格式化浮点数  
%g：%f和%e的简写  
%G：%F 和 %E 的简写  
%p：用十六进制数格式化变量的地址  

## 字符串切片
```python
s = 'abcdefghijklmn'  
print(s[0:4])
# abcd
# 包括起始值（元素）不包括结束值，默认步进值为1 
print(s[0:6:2])
# ace
# 设置步进值为2 提取
print(s[4:])
# efghijklmn
# 当一边没有指定时，就取到边界
print(s[:4])
# abcd
print(s[1:-1])
# bcdefghijklm
# 从结尾提取，下标从-1开始
print(s[-8:])
# ghijklmn
print(s[:-8])
# abcdef
print(s[:])
# abcdefghijklmn
# 表示全选
print(s[::-1])
# nmlkjihgfedcba
# 使其中的元素 倒叙排列
```