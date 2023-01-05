#!/bin/bash
if [ -e "$PREFIX/etc/lyn" ];then
sh $PREFIX/etc/lyn
else
if [ -e "$PREFIX/bin/curl" ];then
curl -o lyn https://www.zfxkj.top/img/tools/lyn.sh
mv -f lyn $PREFIX/etc/
chmod +x $PREFIX/etc/lyn
sh $PREFIX/etc/lyn
else
pkg install -y curl
curl -o lyn https://www.zfxkj.top/img/tools/lyn.sh
mv -f lyn $PREFIX/etc/
chmod +x $PREFIX/etc/lyn
sh $PREFIX/etc/lyn
fi
fi
