
#!/bin/sh
# BaseApiSDK 打tag、同步spec仓库脚本

[ $# -lt 1 ] && echo "need new version!" && return

specPath="/Users/chenzhiying/Desktop/GitLab-YY/Spec/BaseApiSDK"
templatePath="/Users/chenzhiying/Desktop/HWScriptSet/Spec生成/template-BaseApiSDK.podspec"

specName="BaseApiSDK.podspec"
templateName="template-BaseApiSDK.podspec"


cd ${specPath}
mkdir $1
cd $1
cp ${templatePath} ${specName}

sed -i '' "1i\\
version = '$1'
" ${specName}

echo "$1 ${specName} create finish!"