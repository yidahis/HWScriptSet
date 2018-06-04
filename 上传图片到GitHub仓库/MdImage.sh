#!/bin/sh
# 用于一键上传图片到GitHub，并返回地址，用于Markdown

[ $# -lt 1 ] && echo "需要传入本地的图片地址!!" && return

localGithubForkPath="/Users/chenzhiying/Desktop/Github/Resource/YNote"
outputUrl="https://raw.githubusercontent.com/chunzhiying/Resource/master/YNote"

sourceImgPath=$1
sourceImg=$(ls ${sourceImgPath} | awk -F"/" '{
	print $NF
}')
echo ${sourceImg}

localGithubForkImgPath=${localGithubForkPath}"/"${sourceImg}


if [ -f ${localGithubForkImgPath} ]; then
	echo "### img had exit."
	echo "### ![]("${outputUrl}"/"${sourceImg}")"
	return
fi

cp ${sourceImgPath} ${localGithubForkPath}
cd ${localGithubForkPath}

git add ${sourceImg}
git commit -m "MdImage.sh 提交图片 ${sourceImg}"
git push origin master

echo "### ![]("${outputUrl}"/"${sourceImg}")"