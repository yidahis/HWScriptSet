#!/bin/bash

cd /Users/chenzhiying/Library/Developer/Xcode/DerivedData

target1="YYMobile"
target2="TinyVideo"

for file in $(ls); do
	cachePreFix=$(echo ${file} | awk -F"-" '{print $1}')
	if [ ${cachePreFix} == ${target1} ]; then
		echo "delete ${file}"
		rm -rf ${file}
		echo "done"
	fi
	if [ ${cachePreFix} == ${target2} ]; then
		echo "delete ${file}"
		rm -rf ${file}
		echo "done"
	fi
done