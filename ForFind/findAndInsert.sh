#!/bin/bash
# 寻找使用 [NSUserDefaults standardUserDefaults]

searchPath="/Users/chenzhiying/Desktop/YYWork/entmobile-ios_7.8_composite_feature"

userDefaults="GetCoreI(IChannelCore).currentChannelInfo"

importStr="#import \"ChannelDetailInfo.h\""

result=$(grep -r -n -l --exclude-dir=".svn" --exclude-dir="Pods" --exclude-dir="ChannelProject" --exclude-dir="*.xcassets" --exclude="*.h"  ${userDefaults} ${searchPath})

for path in ${result}; do
	echo $path
	sed -i '' "8a\\
	${importStr}
	" ${path}

	# 替换NSUserDefaults
	# sed -i '' "s/\[NSUserDefaults standardUserDefaults\]/YYUserDefaults/g" ${path}

done


