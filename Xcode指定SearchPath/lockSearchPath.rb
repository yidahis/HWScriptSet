require 'xcodeproj'
require 'fileutils'

# Build Phase在BaseService，并使用shell调用
# if [ ${CONFIGURATION} == "Debug" ]; then
#     echo "Lock search header path"
#     echo "Lock search script root : ${SRCROOT}/.."
#     ruby ${SRCROOT}/../lockSearchPath.rb ${SRCROOT}/..
# fi

# 基本路径  
projectBaePth = File.dirname(__FILE__)
if ARGV.length>0
  projectBaePth = ARGV[0];
end


yymobileHeaderSearchPath = Array[
	"$(inherited)",
	"$(SDKROOT)/usr/include/libxml2",
	"$(BUILT_PRODUCTS_DIR)/include/libBaseService",
	"$(BUILT_PRODUCTS_DIR)/include/ChannelProject",
	"$(PODS_ROOT)/yylivesdk/libs/yyprotosdk.framework/Headers/",
	"$(PODS_ROOT)/yyvideolib/libs/yyvideolib.framework/Headers/",
	"$(PODS_ROOT)/yymobileumbrellaframework/libs/yymobileumbrellaframework.framework/Headers/",
	"$(PODS_ROOT)/yysignalsdk/libs/yysignalsdk.framework/Headers/"
];


# 工程路径
yymobilePath = File.join(projectBaePth,"YYMobile.xcodeproj");
baseServicePath = File.join(projectBaePth,'ChannelProject/BaseService.xcodeproj');
channelProjectPath = File.join(projectBaePth,'ChannelProject/ChannelProject.xcodeproj');

mobileProject = Xcodeproj::Project::open(yymobilePath);
# baseServiceProject = Xcodeproj::Project::open(baseServicePath);
# channelProject = Xcodeproj::Project::open(channelProjectPath);

def deleteSearchPath(searchPaths,path)
  
end


# 设置config
mobileProject.targets.each { |target|
  if target.name == 'YYMobile'
    target.build_configurations.each { |config|
		searchPath = config.build_settings['HEADER_SEARCH_PATHS']

		if yymobileHeaderSearchPath != searchPath
			puts "#{config.name} search header path not true!"
			searchPath.clear()
			yymobileHeaderSearchPath.each { |path|
				searchPath.push(path)
			}
			puts "#{searchPath}"
			mobileProject.save(yymobilePath);
			exit 1
		end

		# puts "#{searchPath}"
		# searchPath.clear()
		# puts "#{searchPath}"
		# searchPath.insert(0, '$(inherited)')
    }
  end
}

mobileProject.save(yymobilePath);

# channelProject.targets.each { |target|
#   if target.name == 'ChannelProject'
#     target.build_configurations.each { |config|
#       searchPath = config.build_settings['HEADER_SEARCH_PATHS']
#       searchPath.clear
#       puts(searchPath)

#       # deleteSearchPath(searchPath, '${SRCROOT}/../YYMobile/'                  );
#       # deleteSearchPath(searchPath, '${SRCROOT}/../BaseService/'               );
#       # deleteSearchPath(searchPath, '${SRCROOT}/../ChannelPluginFolder/'       );
#       # deleteSearchPath(searchPath, '$(BUILT_PRODUCTS_DIR)/BaseService/Headers'  );
#       # deleteSearchPath(searchPath, '$(BUILT_PRODUCTS_DIR)/YYMobileHeaders/include');

#       # # 只需要 libxml2 / baseservice 导出 / pod 导出
#       # searchPath.push('"$(BUILT_PRODUCTS_DIR)/BaseService/Headers"')

#     }
#   end
# }
# baseServiceProject.targets.each { |target|
#   if target.name == 'libBaseService'
#     target.build_configurations.each { |config|
#         searchPath = config.build_settings['HEADER_SEARCH_PATHS']
#         puts(searchPath)
#         # searchPath.each { |s|
#         #   if s == '${SRCROOT}/../YYMobile/**'
#         #     searchPath.delete(s)
#         #   end
#         # }
#         # #插入到最前面，防止先搜到了BaseApiSDK
#         # searchPath.insert(0,'${SRCROOT}/../YYMobile/**')

#     }
#   end
# }

puts("lockSearchPath finish..")