
#!/bin/sh
# HWFunctional-YY 打tag、同步spec仓库脚本

[ $# -lt 1 ] && echo "need new version!" && exit 0

sourcePath="/Users/chenzhiying/Desktop/GitLab-YY/HWFunctional-YY"
specPath="/Users/chenzhiying/Desktop/GitLab-YY/Spec-fork/HWFunctional-YY"
specTarget="HWFunctional-YY.podspec"

returnPath=$(pwd)

cd ${sourcePath}
git tag $1
git push --tag
echo "## git tag finish!"

cd ${specPath}
sample=$(ls | head -1)
cp -R ${sample} $1

cd $1
sed -i '' "s/${sample}/$1/" ${specTarget}
echo "## spec create finish！"

pod spec lint ${specTarget} --allow-warnings
echo "## check spec finish！"

cd ${returnPath}

# 打开code.yy.com 提mr
if [[ $# -gt 1 ]]; then
	open -a safari http://code.yy.com/chenzhiying/Spec
fi