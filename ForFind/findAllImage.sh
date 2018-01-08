#!/bin/bash
# 寻找目录下所有的图片资源

targetPath="/Users/chenzhiying/Desktop/allImage"

[ $# -lt 1 ] && echo "need path !" && exit 0

IFS=$'\n'

for image in $(find $1 -name "*.png"); do
	imageName=image | awk -F"/" '{
		print $NL
	}'
	echo ${image}
	# cp ${image} ${targetPath}/${imageName}
 done 
