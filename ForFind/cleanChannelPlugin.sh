#!/bin/sh
# ChannelPlugin 清除

target="/Users/chenzhiying/Desktop/YYWork/entmobile-ios_7.4_composite_feature/ChannelProject/BaseService/Model/ChatConversation/YYFriendConversation.m"

cache="/Users/chenzhiying/Desktop/Bash/data.txt"
cache2="/Users/chenzhiying/Desktop/Bash/data2.txt"


# for i in $(grep -A 5 -n "#if ChannelPlugin" ${target}); do
# 	echo i
# done

# num=$(grep -c "#if ChannelPlugin" ${target})
# channelLine=$(grep -n "#if ChannelPlugin" ${target} | awk -F":" '{
# 	print $1
# }')
# grep -A 5 -n "#if ChannelPlugin" ${target} > ${cache}

# 
getLineNum(){
	grep "$1" ${cache2} | awk -F"$2" '{
		print $1
	}'
}

cat ${cache} | sed '7, $d' > ${cache2}
hasElse=`cat ${cache} | sed '7, $d' | grep -c "#else" `
hasEnd=`cat ${cache} | sed '7, $d' | grep -c "#end"`

# echo ${section}
if [ ${hasElse} -eq 1 ] && [ ${hasEnd} -eq 1 ]; then
	echo "has"
	getLineNum "#else" "-"
fi
# echo ${hasEnd}

# echo ${channelLine}

# grep -A 5 -n "#if ChannelPlugin" ${target} > ${cache}
# echo ${result}