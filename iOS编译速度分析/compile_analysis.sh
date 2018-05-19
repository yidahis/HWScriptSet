#!/bin/bash
# 编译分析

logTargetPath="/Users/chenzhiying/Desktop/Data/YYMobile_compile_log/"
projectPath="/Users/chenzhiying/Desktop/YYWork/entmobile-ios_7.8_composite_feature"

# log文件生成
cd ${logTargetPath}
fileDate=`date "+%Y-%m-%d(%H%M)"`
logPath="${logTargetPath}${fileDate}[original].log"
analysisPath="${logTargetPath}${fileDate}[analysis].log"
touch ${logPath}
touch ${analysisPath}

# 开始编译
cd ${projectPath}
echo "clean start..."
xcodebuild clean -workspace YYMobile.xcworkspace -scheme YYMobile -configuration Release > /dev/null
echo "clean finished !!"

echo "compile start..."
# xcodebuild -configuration Release -workspace YYMobile.xcworkspace -scheme YYMobile | xcpretty | gnomon > ${logPath}
xcodebuild archive -workspace YYMobile.xcworkspace -scheme YYMobile -archivePath "${logTargetPath}YYMobile.xcarchive" | xcpretty | gnomon > ${logPath}
echo "compile finished !!"

# 分析文件的生成
totalTime=`grep "Total.*s$" ${logPath}`
sort -r ${logPath} | head -n 100 > ${analysisPath}
sed -i '' "1c\\
${totalTime} 
" ${analysisPath}
# sed -i '' "2d" ${analysisPath}

echo "all finished !!"


# 测试代码
# analysisPath="/Users/chenzhiying/Desktop/Data/compile-analysis.log"
# logPath="/Users/chenzhiying/Desktop/Data/compile.log"




