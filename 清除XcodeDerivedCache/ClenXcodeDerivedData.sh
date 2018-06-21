#!/bin/bash

cd /Users/chenzhiying/Library/Developer/Xcode/DerivedData

target="YYMobile"


for file in $(ls); do
	cachePreFix=$(echo ${file} | awk -F"-" '{print $1}')
	if [ ${cachePreFix} == ${target} ]; then
		echo "delete ${file}"
		rm -rf ${file}
		echo "done"
	fi
done