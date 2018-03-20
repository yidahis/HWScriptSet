# targetDir=${SRCROOT}
targetDir="/Users/chenzhiying/Desktop/YYWork/entmobile-ios_7.5_composite_feature"

echo "YYUserdefaults scan begin targetDir:$targetDir"

userDefaults="NSUserDefaults"

# 白名单
whiteList=("YYUserDefaults.m" "YYLaboratoryViewController.m" "YYWebAppFramework.m" "YYLaunchSteps.m")


result=$(grep -r -n  --exclude-dir=".svn" --exclude-dir="YYMobileUITests" --exclude-dir="Pods" --exclude-dir="xcuserdata" --exclude-dir="*.xcassets" --exclude-dir="*.framework" --exclude="*.h" --exclude="*.a" --exclude="*.txt" --exclude="*.sh"  ${userDefaults} ${targetDir})

for file in ${result}; do
	echo $file
	# fileName=$(echo ${file} | awk -F"/" '{print $NF}')
	# inWhiteList=false
	# for (( i = 0; i < ${#whiteList[@]}; i++ )); do
	# 	if [ ${fileName} == ${whiteList[i]} ]; then
	# 		inWhiteList=true
	# 	fi
	# done
	# if [ "$inWhiteList" = false ]; then
	# 	echo "Please use 'YYUserDefaults' to replace 'NSUserDefaults' in $file"
	# 	exit 1
	# fi
done

echo "YYUserDefaults scan finish"







