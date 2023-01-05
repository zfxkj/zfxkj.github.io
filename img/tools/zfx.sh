#!/bin/bash
url=https://www.zfxkj.top/img/tools/
work=$HOME/.zfx
#判断wget是否存在
if [ ! -e $PREFIX/bin/wget ]
then
	sudo apt install -y wget
fi
#判断工作目录是否存在
if [ ! -d $work ]; then
  mkdir $work
fi
#判断程序是否第一次使用
if [ ! -e $work/zfx ]
then
    sudo apt update -y
    sudo apt upgrade -y
    sudo apt list --upgradable
	wget $url'zfx.sh' -P $work -q
	mv $work/zfx.sh $work/zfx
	chmod +x $work/zfx
    wget $url'main.sh' -P $work -q
    az=$(date "+%Y%m%d")
    echo $az > $work/update
    if [ -e $HOME/.zshrc ]
    then
        echo "export PATH=$HOME/.zfx/zfx:$PATH" >> $HOME/.zshrc
        source $HOME/.zshrc
    else
        echo "export PATH=$HOME/.zfx/zfx:$PATH" >> $HOME/.bashrc
        source $HOME/.bashrc
    fi
    echo "下载完成"
    echo "安装完成"
    echo "以后每次的启动命令是：zfx"
	exit 0
fi
acz=$(date "+%Y%m%d")
as=$(cat $work/update)
asz=`expr $as + 2`
#判断程序是否需要更新
if [ ! $asz -ge $acz ]
then
    echo $acz > $work/update
    rm -rf $work/zfx
    rm -rf $work/main.sh
    wget $url'zfx.sh' -P $work -q -O 'zfx'
	chmod +x $work/zfx
    wget $url'main.sh' -P $work -q
    echo "更新完成"
fi
if [ -e $work/main.sh ]
then
	bash $work/main.sh
else
    echo "开始下载"
	wget $url'main.sh' -P $work -q
    echo "下载完成"
    echo "安装完成"
	bash $work/main.sh
fi