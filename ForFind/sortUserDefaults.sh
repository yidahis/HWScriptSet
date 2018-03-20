#!/bin/bash


searchPath="/Users/chenzhiying/Desktop/YYWork/entmobile-ios_7.5_composite_feature/ChannelProject"
targetPath="/Users/chenzhiying/Desktop/Bash/data/sortUserDefaults.txt"

userDefaults="YYUserDefaults"

importStr="#import \"YYUserDefaults.h\""

result=$(grep -r -n -l --exclude-dir=".svn" --exclude-dir="Pods" --exclude-dir="*.xcassets" --exclude="*.h" ${userDefaults} ${searchPath})

for path in ${result}; do

	echo $path >> ${targetPath}
	grep "objectForKey:" ${path} >> ${targetPath}
	grep "boolForKey:" ${path} >> ${targetPath}
	grep "integerForKey:" ${path} >> ${targetPath}
	grep "floatForKey:" ${path} >> ${targetPath}
	echo '--------------------------------------------' >> ${targetPath}
	echo '--------------------------------------------' >> ${targetPath}

	# 指定行插入
	# sed -i '' "7a\\
	# ${importStr}" ${path}

	# 替换NSUserDefaults
	# sed -i '' "s/\[NSUserDefaults standardUserDefaults\]/YYUserDefaults/g" ${path}

done



