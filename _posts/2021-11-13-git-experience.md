---
layout: post
title: 初学者的Git
subtitle: "Git的一些简单而且常用的操作"
category : [Git]
tags : [Git,GitHub,Gitee]
date:       2021-11-13
author:     "晨曦"
header-img: "https://tc.zfxkj.top/picgo/imgpostgit-bg-6d7a5b65-872e-4846-b0dd-9e9e05fd7556.jpg.jpg"
description:  "本文主要介绍一些简单的命令：包括clone, add, commit, push, pull, branch等"
---
  
## 目录
{: .no_toc}

* 目录
{:toc}

## 介绍  
  很多初学者可能并不太清楚Git与GitHub这两个概念的联系和区别，在这里我大致介绍一下这两个名词。  
  [Git](https://git-scm.com/ "Git")是一个免费、开源的分布式版本控制系统(VCS)。  
  版本控制系统是一种记录一个或若干文件内容变化，以便将来查阅特定版本修订情况的系统。版本控制系统不仅可以应用于软件源代码的文本文件，而且可以对任何类型的文件进行版本控制。版本控制系统分为集中式的版本控制系统(CVCS)比如SVN、VSS和分布式版本控制系统(DVCS)比如Git、Bazaar，前者有一个单一的集中管理的服务器，保存所有文件的修订版本，协同工作的人们通过客户端连接到这台服务器，获取最新的文件或者提交更新，不过显而易见的缺点就是中央服务器的单点故障问题。如果宕机，那么就会出现谁都无法提交更新的情况，那么也就无法协同工作甚至会丢失数据；分布式版本控制系统的特点是用户每次迁出的不是某一个版本的快照，而是原始数据的整个镜像。因此当服务器发生故障的时候，可以用任何一个本地镜像进行恢复。  
  [GitHub](https://github.com/ "GitHub")是一个用Git做版本控制的代码托管平台。它在代码托管领域是先行者，与之类似的还有Gitlab、Bitbucket、GitCafe等。  
## clone  
  如果你经常在网上下载一些源码之类的话，这段命令你就再熟悉不过了。这是克隆仓库的命令，其格式为`git clone [url]`。比如,要克隆 GitHub用户`zfb132`的代码仓库`zfb132.github.com`，可以用下面的命令：  
`git clone git@github.com:zfb132/zfb132.github.com.git`  
  这会在当前目录下创建一个名为`zfb132.github.com`的目录，其中包含一个`.git`的目录，用于保存下载下来的所有版本记录，然后从中取出最新版本的文件拷贝。如果进入这个新建的`zfb132.github.com`目录，你会看到项目中的所有文件已经在里边了。如果希望在克隆的时候，自己定义要新建的项目目录名称，可以在上面的命令末尾指定新的名字：  
`git clone git://github.com/zfb132/zfb132.github.com.git myName`  
  
## init  
  要对现有的某个项目开始用Git管理，只需到此项目所在的目录，执行命令：  
`git init`  
  初始化后，在当前目录下会出现一个名为`.git`的目录，所有Git需要的数据和资源都存放在这个目录中。不过这只是初始化，还没有开始跟踪管理项目中的任何一个文件。  
  
## add  
  如果当前目录下有一个文件test.py想要纳入版本控制，需要使用此命令:  
`git add test.py`  
  需要注意的是，add命令后面支持简化的[正则表达式](https://msdn.microsoft.com/zh-cn/library/ae5bf541.aspx "正则表达式的百科介绍")，比如：  
  `git add *.py`  
  `git add .`
  前者表示将该目录下所有扩展名为py的加入版本控制，后者表示将该目录下所有文件加入版本控制。  
  
## branch  
  列出本地已经存在的分支，并且在当前分支的前面加`*`号标记:  
`git branch`  
  列出远程分支：  
`git branch -r`  
  列出本地分支和远程分支，并且在当前分支的前面加`*`号标记:  
`git branch -a`  
  在本地创建一个新的分支test：  
`git branch test`  
  切换分支到test（如果当前不在test分支的话）：  
`git checkout test`  
在本地创建并切换到test分支：  
`git checkout -b test`  
  在本地删除一个名为test的分支：  
`git branch -d test`  
  在远程删除test分支只需要再加上`-r`参数即可  
  
## remote  
  列出已经存在的远程分支的简要信息：  
`git remote`  
  列出远程分支的详细信息（在每一个名字后面列出其远程url）：  
`git remote -v`  
  添加一个新的远程仓库origin（此处origin自定义，代表的是远程仓库myTest）：  
`git remote add origin git@github.com:zfb132/myTest.git`  
  
## commit  
  提交当前工作目录的修改内容，一般都会加上`-m`参数填写修改描述：  
`git commit -m "修复若干bug"`  

## pull  
  取回远程仓库的next分支与本地的master分支合并：  
`git pull origin next:master`  
  如果远程分支是与当前分支合并，则可以省略一部分：  
`git pull origin next`  
  如果当前分支与远程分支存在追踪关系，则可以省略远程分支名：  
`git pull orign`  
  如果当前分支只有一个追踪分支，可以继续省略：  
`git pull`  
  
## push  
  push命令与pull命令是类似的，因此只举一个例子，上传本地当前分支到远程master分支：  
`git push -u origin master`  
  如果已经在本地新建一个dev分支，但是远程仓库并没有这个分支，可以使用以下命令在远程建立dev分支的同时把本地的dev分支推送到远程的dev分支（需要**保证此时在dev分支下**执行命令）：  
`git push origin dev:dev`  

## tag
  删除远程v2.23.1的tag：  
`git push --delete origin v2.23.1`  
  删除本地tag：  
`git tag -d v2.23.1`  
  新建tag：  
`git tag -a v2.23.1 -m "描述"`  
  同步tag到远程：  
`git push --tags`  

## log
  查看最近5次的提交日志：  
`git log -5`  
  **对于Windows系统**查看日志，如果commit message包含中文可能会有乱码，如下所示，实际提交内容为`添加cnzz统计`，显示结果如下：  
```text
PS E:\github\zfb132.github.com> git show -s --format=%s
<E6><B7><BB><E5><8A><A0>cnzz<E7><BB><9F><E8><AE><A1>
```
  此命令的作用是显示上一次提交的message信息（与此命令功能一致`git log --pretty=format:"%s" -1`）  
  解决办法：在终端输入以下两行命令  
```bash
# 设置提交时message以utf-8编码保存
git config --global i18n.commitEncoding utf-8
# 设置查看时message以utf-8编码传递给查看器
git config --global i18n.logOutputEncoding utf-8
```
  然后再添加环境变量，选择用户变量即可，变量名为`LESSCHARSET`，内容为`utf-8`  
  **对于Linux系统**而言，只需要最后一步改为`export LESSCHARSET=utf-8`  

## reset
* `git reset HEAD`表示当前版本，运行后并不会有什么变化
* `git reset --hard HEAD~1`表示彻底回退所有内容到上一个提交的版本
* `git reset --hard HEAD^`表示彻底回退所有内容到上一个提交的版本
* `git reset --hard ffffffffffa6b556a6b556a6b556a6b556461461`表示彻底回退所有内容到指定的commit版本（也可使用hash值的前六位代表这次提交）

  撤销已经push到远程的commit的方法：  
* 先使用上面的方法回退
* 然后执行如下命令推送到远程`git push -f origin master`，此时远程就看不到已经撤回的记录了，而且tree是干净的

  
## 配置git
安装Git软件后即可使用其版本控制功能，但是如果想要把修改推送到GitHub还需要配置添加证书，具体操作如下：  
```bash
# 生成证书，会提示输入保存密钥对的路径、保护私钥的密码（直接回车表示使用默认设置）
ssh-keygen -t rsa -C myemail@example.com
# 以下两个步骤是为了push操作而进行的，如果只需要clone等则不需要执行
# 设置全局用户名为github的用户名
git config --global user.name "my_github_username"
# 设置全局用户名为自己的邮箱
git config --global user.email myemail@example.com
# 设置全局代理
git config --global http.proxy http://127.0.0.1:1080
git config --global https.proxy http://127.0.0.1:1080
# 取消全局代理
git config --global --unset http.proxy
git config --global --unset https.proxy
# 将输出的内容（以ssh-rsa开头，以myemail@example.com结尾）复制
cat ~/.ssh/id_rsa.pub
```
然后登录自己的GitHub账户，在[设置里面](https://github.com/settings/ssh/new)添加SSH秘钥即可  
此时在本地终端即可输入`git clone git@github.com:zfb132/zfb132.github.com.git`命令来下载代码  
## 示例  
  以下内容是在安装配置好git的前提下才能正常进行的，如果你需要将自己的远程仓库下载到本地`E:\github`目录下，修改后再上传到原仓库的`master`分支  
  按照以下步骤：
* 切换到你的工作目录`E:\github`  
* 下载远程仓库到本地：`git clone git@github.com:zfb132/zfb132.github.com.git`，其中`git@github.com:zfb132/zfb132.github.com.git`是在点击下载按钮时显示的地址，不同的仓库对应不同的地址  
* 在本地修改后，终端切换到`E:\github\zfb132.github.com`，其中`zfb132.github.com`是自动生成的对应于这个仓库的目录  
* 输入`git branch`，输出分支的名字（假设显示`* master`,就是属于`master`分支）  
* 输入`git add .`，添加文件  
* 输入`git commit -m "修复bug"`，提交修改记录  
* 输入`git remote add origin git@github.com:zfb132/zfb132.github.com.git`（大部分时候并不需要）  
* 输入`git push -u origin master`（`master`为刚才查看的分支名）  

  等待完成后，再进入网页查看就已经更新了

## 恢复被强制推送push失踪的代码
在常规的开发流程中，难免有时因为各种原因（例如需要使用git rebase）会需要使用到git push -f，也就是强制推送，该命令会覆盖远程分支。  
但如果操作不当，会容易把小伙伴的之前提交的commit给覆盖掉，不要慌，这并不代表你小伙伴的commit已经永远找不回来了，大部分情况下，他们还是可以被找回的。  
```text
git reflog 可以查看所有分支的所有操作记录（包括（包括commit和reset的操作），包括已经被删除的commit记录，git log则不能查看已经删除了的commit记录
```
虽然有reflog这跟救命稻草，但由于Git会定时gc（回收），清理掉reflog，所以被人覆盖后不要等待太久才进行恢复操作，不然可能就真的找不回了。  
### 操作方法
1.备份当前工作区的数据  
你可以使用git stash等命令备份下现在正在写的代码  

2.在命令行输入git reflog/git log -g  
显示所有历史操作，找到你需要的提交（包括已经被删除的commit记录，git log则不能察看已经删除了的commit记录）  
![git_force](https://tc.zfxkj.top/picgo/git_force.png)  
2.1 强制回退到当时被删除的commit  
`git reset --hard <SHA1>`  
2.2 或者直接  
`git cherry-pick <SHA1>`  
直接把当时版本的工作拿回来。不过如果有冲突的话还要处理冲突。  
3.强推上远程分支  
`git push -f origin <branch>`  
如果引起commit丢失的原因并没有记录在reflog 中，比如运行了rm -Rf .git/logs/, 因为 reflog 数据是保存在 .git/logs/ 目录下的，这样就没有 reflog 了。  
可以使用 git fsck 工具，该工具会检查仓库的数据完整性。如果指定 --full 选项，该命令显示所有未被其他对象引用 (指向) 的所有对象：  
![git_fsck](https://tc.zfxkj.top/picgo/git_fsck.png)  
然后，用相同的方法就可以恢复它，即创建一个指向该 SHA 的分支。  

### 转载说明
本文章转载自[晨曦的博客](https://blog.whuzfb.cn)，非原创！！！
