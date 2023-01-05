#!/bin/bash
if [ ! -e $PREFIX/bin/dialog ]
then
    sudo apt install -y dialog
fi
url=https://www.zfxkj.top/img/tools/
work=$HOME/.zfx
fdinfo() {
	dialog --backtitle $1 --infobox $2 20 50
}

fdyn() {
	dialog --backtitle $1 --yes-label $2 --no-label $3 --yesno $4 20 50
}
success() {
	dialog --backtitle ZFX工具箱 --ok-label 按回车键继续… --msgbox $1 20 50
}
function diinfo() {
    text1="欢迎使用，本程序由ZFX制作。\n使用本程序会在家目录($home)\n下创建一个.zfx文件夹，\n该文件夹会存储关于本项目的所有文件\n如果觉得本程序是恶意程序可以拒绝使用！！！\n拒绝使用会删除所本程序所创建的文件夹\n不会卸载通过此件本安装的程序\n程序内部部分脚本并非本人所写！！！\n如果有好的项目想要加入本程序可以邮箱联系。↓\n联系方式：2675699284@qq.com"
	fdyn ZFX工具箱 进入程序 拒绝使用 $text1
	while :
	do
		menu
	done
}
function exit1() {
    clear
    exit 0
}
function menu() {
	menu1=$(dialog \
		--backtitle ZFX工具箱 \
		--stdout \
		--ok-label 确认 \
		--cancel-label 退出 \
		--menu 请选择命令 \
		20 50 4 \
		1 "安装zsh" \
		2 "更换termux源" \
		3 "卸载此程序")
	nexit=$?#如果nexit不等于0就退出
	if [ $nexit != 0 ]
	then
	    exit1
	else
	    menu_info
	fi
}
function menu_info() {
	case $menu1 in
		1)
			sudo apt install -y zsh git curl
			echo "正在更换为zsh\n请输入账户密码"
			chsh -s /bin/zsh
			sh -c "$(curl -fsSL https://gitee.com/zfx521/ohmyzsh/raw/master/tools/install.sh)"
			if [ ! -e $HOME/.zshrc ]
			then
				wget $url'.zshrc' -P $HOME -q
			fi
			git clone https://gitee.com/zfx521/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
			git clone https://gitee.com/zfx521/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
			sed -i 's/^plugins=(git)/plugins=(git zsh-syntax-highlighting zsh-autosuggestions)/g' $HOME/.zshrc
			success "zsh安装成功\n默认采用自带的主题"
			echo "export PATH=$HOME/.zfx/zfx:$PATH" >> $HOME/.zshrc
			if [ ! -e /usr/bin/neofetch ]
			then
				sudo apt install neofetch
			fi
			echo "echo\ndf -h\necho\nneofetch" >> $HOME/.zshrc
			source $HOME/.zshrc
			menu
			;;
		2)
		    echo "正在开发中。。。"
			;;
		3)
	    	rm -rf $work
	    	unmain="程序卸载完毕！"
	    	success $unmain
	    	exit 0
		    ;;

	esac
}

    
