#!/bin/bash
# 搜索指定目录下某个关键字的使用次数

dataRootPath="/Users/chenzhiying/Desktop/Data/"
searchRootPath="/Users/chenzhiying/Desktop/YYWork/"

projectName="entmobile-ios_7.8_composite_feature"
subProjectName="tinyvideo-ios_7.8_money_livekit_feature"

searchPath="${searchRootPath}${projectName}"
subSearchPath="${searchRootPath}${subProjectName}"

dataPath="${dataRootPath}${projectName}-protocols.log"
subDataPath="${dataRootPath}${subProjectName}-protocols.log"
deletePath="${dataRootPath}${projectName}-shouldDeleteHeaders.log"
deleteCoreIPath="${dataRootPath}${projectName}-shouldDeleteCoreIHeaders.log"


targetStr="GetCoreI([a-zA-Z]*)"
usedHeaders=()
subUsedHeaders=()

# 寻找关键字并重定向到data文件
grep -r -o --exclude-dir=".svn" --exclude-dir="YYMobileUITests" --exclude-dir="xcuserdata" --exclude-dir="*.xcassets" --exclude-dir="*.framework" --include="*.m" --include="*.mm" "$targetStr" "$searchPath" | awk -F":" '{print $NF}' | sort | uniq -c | sort -r  > ${dataPath}
echo "YYMobile导出完成"

# 寻找关键字并重定向到data文件
grep -r -o --exclude-dir=".svn" --exclude-dir="YYMobileUITests" --exclude-dir="xcuserdata" --exclude-dir="*.xcassets" --exclude-dir="*.framework" --include="*.m" --include="*.mm" "$targetStr" "$subSearchPath" | awk -F":" '{print $NF}' | sort | uniq -c | sort -r  > ${subDataPath}
echo "TinyVideo导出完成"

# 遍历项目中使用到的所有Ixxx.h文件（IM等文件也可能会包含，需要后续过滤）
allHeaders=$(find ${searchPath} -name "I[a-zA-Z]*\.h" | awk -F"/" '{print $NF}')


# 将YYMobile、TinyVideo使用的CoreI导入到数组中
index=0
for header in $(cat ${dataPath} | sed 's/\(GetCoreI\)/\1|/' | awk -F"|" '{print $NF}' | sed 's/(//g' | sed 's/)//g' | sed 's/^.*/&.h/'); do
	usedHeaders[$index]=$header
	index=$index+1
done 
echo "YYMobile使用的CoreI：${#usedHeaders[@]}"
for header in $(cat ${subDataPath} | sed 's/\(GetCoreI\)/\1|/' | awk -F"|" '{print $NF}' | sed 's/(//g' | sed 's/)//g' | sed 's/^.*/&.h/'); do
	usedHeaders[$index]=$header
	index=$index+1
done 

echo "usedHeader all count : ${#usedHeaders[@]}"
echo "usedHeader : ${usedHeaders[@]}"
echo "not used header：" > ${deletePath}


# 过滤使用到的CoreI
for header in ${allHeaders}; do
	used=false
	for (( i = 0; i < ${#usedHeaders[@]}; i++ )); do
		if [[ ${header} == ${usedHeaders[i]} ]]; then
			used=true
		fi
	done
	if [ $used = false ]; then
		echo $header >> ${deletePath}
	fi
done


# 删掉delegate、bridge、IM文件
grep -v "Delegate.h$" ${deletePath} | grep -v "Bridge.h$" | grep -v "^Im" |sort | uniq -c > ${deleteCoreIPath}

echo "all finished"







