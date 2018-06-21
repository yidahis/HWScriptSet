#!/bin/bash
# 替换


searchPath="/Users/chenzhiying/Desktop/YYWork/entmobile-ios_7.9_composite_feature"
# searchPath="/Users/chenzhiying/Desktop/YYWork/entmobile-ios_7.8_maint"


targetStr="#import \"YYPayOne[a-zA-Z\.]*\""
replaceStr=""

# targetStr2="#import \"YYHTTPSConfigCore.h\""
# replaceStr2="#import \"IYYHTTPSConfigCore.h\""

whiteList=("")

# importStr="#import \"YYUserDefaults.h\""

result=$(grep -r -n -l --exclude-dir=".svn" --exclude-dir="YYMobileUITests" --exclude-dir="Pods" --exclude-dir="xcuserdata" --exclude-dir="*.xcassets" --exclude-dir="*.framework" --include="*.m" --include="*.h" --include="*.mm" "$targetStr" $searchPath)


for file in ${result}; do
	echo ${file}
	fileName=$(echo ${file} | awk -F"/" '{print $NF}')
	inWhiteList=false
	for (( i = 0; i < ${#whiteList[@]}; i++ )); do
		if [ ${fileName} == ${whiteList[i]} ]; then
			inWhiteList=true
		fi
	done
	if [ "$inWhiteList" = false ]; then
		sed -i '' "s/$targetStr/$replaceStr/g" ${file}
		# sed -i '' "s/$targetStr2/$replaceStr2/g" ${file}
	fi
done

	# 指定行插入
	# sed -i '' "7a\\
	# ${importStr}" ${path}

	# 替换NSUserDefaults
	# sed -i '' "s/\[NSUserDefaults standardUserDefaults\]/YYUserDefaults/g" ${path}





