#!/bin/sh
# 批量符号化系统堆栈

[ $# -lt 2 ] && echo "需要输入yymobile起始地址、需解析堆栈的文件地址" && return

if [ ! -d "YYMobile.app.dSYM" ]; then 
	echo "YYMobile.app.dSYM 必须在当前目录"
	return
fi 

originalAddress=$1
stackLocation=$2

result=$(grep 'YYMobile' $stackLocation | awk '{print $2}')
echo '解析中，请稍后...'
for address in ${result}; do
	symbolizeAddress=$(atos -o YYMobile.app.dSYM/Contents/Resources/DWARF/YYMobile -arch arm64 -l ${originalAddress} ${address})
	sed -i '' "s/${address}/${symbolizeAddress}/g" ${stackLocation}
	echo "done ${address}"
done
echo 'all done'
