require 'xcodeproj'

# 使用
# export LANG=en_US.UTF-8
# export LANGUAGE=en_US.UTF-8
# export LC_ALL=en_US.UTF-8
# if [ ${CONFIGURATION} == "Debug" ]; then
#      echo "Lock search header path"
#      echo "Lock search script root : ${SRCROOT}"
#      ruby ${SRCROOT}/HeaderSearchPathCheck.rb
# fi


# 基本路径  
projectBaePth = File.dirname(__FILE__)
if ARGV.length>0
  projectBaePth = ARGV[0];
end


yymobileExpectPath = Array[
	"$(inherited)",
	"$(SDKROOT)/usr/include/libxml2",
	"\"$(BUILT_PRODUCTS_DIR)/include/libBaseService\"",
	"\"$(BUILT_PRODUCTS_DIR)/include/ChannelProject\"",
	"\"$(PODS_ROOT)/yylivesdk/libs/yyprotosdk.framework/Headers/\"",
	"\"$(PODS_ROOT)/yyvideolib/libs/yyvideolib.framework/Headers/\"",
	"\"$(PODS_ROOT)/yymobileumbrellaframework/libs/yymobileumbrellaframework.framework/Headers/\"",
	"\"$(PODS_ROOT)/yysignalsdk/libs/yysignalsdk.framework/Headers/\""
];

channelProjectExpectPath = Array[
	"$(inherited)",
	"\"$(SDKROOT)/usr/include/libxml2\"",
	"\"$(BUILT_PRODUCTS_DIR)/include/libBaseService\"",
	"\"${PODS_ROOT}/React\"/**",
	"\"$(PODS_ROOT)/yylivesdk/libs/yyprotosdk.framework/Headers/\"",
	"\"$(PODS_ROOT)/yyvideolib/libs/yyvideolib.framework/Headers/\"",
	"\"$(PODS_ROOT)/yysignalsdk/libs/yysignalsdk.framework/Headers/\""
];

baseServiceExpectPath = Array[
	"$(inherited)",
	"$(SDKROOT)/usr/include/libxml2",
	"\"$(PODS_ROOT)/yylivesdk/libs/yyprotosdk.framework/Headers/\"",
	"\"$(PODS_ROOT)/yyvideolib/libs/yyvideolib.framework/Headers/\"",
	"\"$(PODS_ROOT)/yysignalsdk/libs/yysignalsdk.framework/Headers/\""
];


# 工程路径
yymobilePath = "#{projectBaePth}/YYMobile.xcodeproj";
baseServicePath = "#{projectBaePth}/ChannelProject/BaseService.xcodeproj";
channelProjectPath = "#{projectBaePth}/ChannelProject/ChannelProject.xcodeproj"


# reset
def resetToPreferHeaderSearchPath(target,expectPath,factPath)
	factPath.clear()
	expectPath.each { |path|
		factPath.push(path)
	}
	puts "#{target} header search path reset to expect!"
end


# 检测是否符合Header Search Path是否符合预期
def checkHeaderSearchPath(projectPath,targetName,expectPath)
	project = Xcodeproj::Project::open(projectPath);
	project.targets.each { |target|
	  if target.name == targetName
	    target.build_configurations.each { |config|
			factPath = config.build_settings['HEADER_SEARCH_PATHS']
			if !(((expectPath - factPath).size == 0) && (expectPath.size == factPath.size))
				puts "【#{target.name} #{config.name}】 search header path not match: "
				puts "expect: --- #{expectPath}"
				puts "fact: --- #{factPath}"

				resetToPreferHeaderSearchPath(target,expectPath,factPath)
				project.save(projectPath);
				exit 1
			end
	    }
	  end
	}
	puts "#{targetName} check finish!"
end


checkHeaderSearchPath(yymobilePath, 'YYMobile', yymobileExpectPath)
checkHeaderSearchPath(baseServicePath, 'libBaseService', baseServiceExpectPath)
checkHeaderSearchPath(channelProjectPath, 'ChannelProject', channelProjectExpectPath)


puts("lockSearchPath finish..")