#!/bin/bash
# 寻找没有使用的图片

searchPath="/Users/chenzhiying/Desktop/YYWork/entmobile-ios_7.1_maint"
targetPath="/Users/chenzhiying/Desktop/Bash/data/findNotUseImage.txt"

# [ $# -lt 1 ] && echo "need path!" && exit 0

images=$(find ${searchPath} -name "*.imageset" | awk -F"/" '{print $NF}' | awk -F"." '{print $1}')
imagesAry=(${images})
totalCount=${#imagesAry[@]}

index=0

IFS=$'\n'

for image in ${images}; do

	 result=$(grep -r -n --exclude-dir=".svn" --exclude-dir="Pods" --exclude-dir="*.xcassets" \"${image}\" ${searchPath})
	 # for path in ${result}; do
	 # 	echo ${path}
	 # done
	 resultAry=(${result})

	 resultCount=${#resultAry[@]}
	 index=$(( $index + 1 ))

	 # echo "--------------------------"
	 echo ${image}: find ${resultCount}, progress: ${index}/${totalCount}
	 # echo "=========================="

	 if [[ ${resultCount} -lt 1 ]]; then
	 	echo ${image} >> ${targetPath}
	 fi

done

 