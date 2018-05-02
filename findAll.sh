#!/bin/bash
# 搜索指定目录下某个关键字的使用次数

dataPath="/Users/chenzhiying/Desktop/Data/protocols.log"
searchPath="/Users/chenzhiying/Desktop/YYWork/entmobile-ios_7.7_maint"

targetStr="GetCoreI([a-zA-Z]*)"

# 寻找关键字并重定向到data文件
grep -r -o --exclude-dir=".svn" --exclude-dir="YYMobileUITests" --exclude-dir="Pods" --exclude-dir="xcuserdata" --exclude-dir="*.xcassets" --exclude-dir="*.framework" --include="*.m" --include="*.mm" "$targetStr" "$searchPath" | awk -F":" '{print $NF}' | sort | uniq -c | sort -r  > ${dataPath}
echo "finish！"









