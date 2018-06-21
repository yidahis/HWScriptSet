source = { :git => 'http://code.yy.com/ios_team/BaseApiSDK.git'}
source[:tag] = "v#{version}"
Pod::Spec.new do |s|
  s.name             = "BaseApiSDK"
  s.version          = version
  s.summary          = "BaseApiSDK."
  s.homepage         = "https://github.com/silan-liu"
  s.license =  { :type => 'BSD' }
  s.source   = source
  s.author           = { "silan" => "413769707@qq.com" }
  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.xcconfig = { 'OTHER_CFLAGS' => '-DSQLITE_HAS_CODEC', 'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libxml2'}
  s.default_subspec = 'All'
  s.subspec 'All' do |spec|
    spec.prefix_header_file = 'BaseApiSDK/BaseApiSDK-Prefix.pch'
    spec.ios.dependency 'BaseApiSDK/ARC'
    spec.ios.dependency 'BaseApiSDK/UnARC'
    spec.ios.dependency 'BaseApiSDK/JSONCategory'
    spec.dependency 'ZipArchive'
    spec.dependency 'SZTextView'
  #  spec.dependency 'AFNetworking/Serialization'
  #  spec.dependency 'AFNetworking/Security'
  #  spec.dependency 'AFNetworking/Reachability'
  #  spec.dependency 'AFNetworking/NSURLSession'
  #  spec.dependency 'AFNetworking/UIKit'
    spec.dependency 'JSONModel'
    spec.dependency 'RaptureXML'
    spec.dependency 'AMapSearch-NO-IDFA', '5.2.1'
    spec.dependency 'AMapFoundation-NO-IDFA', '1.4.3'
    spec.dependency 'KVOController'
    spec.dependency 'openssl-dynamic'
  end
  s.subspec 'JSONCategory' do |spec|
    spec.prefix_header_file = 'BaseApiSDK/BaseApiSDK-Prefix.pch'
    spec.requires_arc            = false
    spec.compiler_flags          = '-w -Xanalyzer -analyzer-disable-checker -Xanalyzer deadcode'
    spec.source_files = 'BaseApiSDK/Framework/JSON/JSONCategory.m'
  end
  s.subspec 'UnARC' do |spec|
    spec.prefix_header_file = 'BaseApiSDK/BaseApiSDK-Prefix.pch'
    spec.requires_arc            = false
    spec.source_files = 'BaseApiSDK/Framework/HTTP/NSString+URL.m','BaseApiSDK/Framework/Security/GTMBase64/GTMBase64.m'
  end
  s.subspec 'Reachability' do |spec|
    spec.requires_arc            = true
    spec.source_files = 'BaseApiSDK/Framework/Utility/Reachability/YYReachability.{h,m}'
  end
  s.subspec 'ARC' do |spec|
    spec.prefix_header_file = 'BaseApiSDK/BaseApiSDK-Prefix.pch'
    spec.requires_arc        = true
    spec.source_files = 'BaseApiSDK/**/*.{h,m,c,cpp,mm}'
    spec.resource = 'BaseApiSDK/**/*.{xib,png}'
  end
end