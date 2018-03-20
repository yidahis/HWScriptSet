#!/bin/bash
# 寻找使用 [NSUserDefaults standardUserDefaults]

searchPath="/Users/chenzhiying/Desktop/YYWork/entmobile-ios_7.5_composite_feature"

userDefaults="NSUserDefaults"
userDefaultsObj="[NSUserDefaults standardUserDefaults]"

importStr="#import \"YYUserDefaults.h\""

result=$(grep -r -n -l --exclude-dir=".svn" --exclude-dir="Pods" --exclude-dir="ChannelProject" --exclude-dir="*.xcassets" --exclude="*.h"  ${userDefaults} ${searchPath})

for path in ${result}; do
	echo $path
	指定行插入
	sed -i '' "7a\\
	${importStr}" ${path}

	# 替换NSUserDefaults
	# sed -i '' "s/\[NSUserDefaults standardUserDefaults\]/YYUserDefaults/g" ${path}

done


