#!/bin/bash
# 搜索指定目录下某个关键字的使用次数

dataRootPath="/Users/chenzhiying/Desktop/Data/"
searchRootPath="/Users/chenzhiying/Desktop/YYWork/"

projectName="tinyvideo-ios_7.8_money_livekit_feature"

dataPath="${dataRootPath}${projectName}-protocols.log"
searchPath="${searchRootPath}${projectName}"


targetStr="GetCoreI([a-zA-Z]*)"

# 寻找关键字并重定向到data文件
grep -r -o --exclude-dir=".svn" --exclude-dir="YYMobileUITests" --exclude-dir="xcuserdata" --exclude-dir="*.xcassets" --exclude-dir="*.framework" --include="*.m" --include="*.mm" "$targetStr" "$searchPath" | awk -F":" '{print $NF}' | sort | uniq -c | sort -r  > ${dataPath}
echo "finish！"









