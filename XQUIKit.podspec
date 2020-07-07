#
#  Be sure to run `pod spec lint XQUIKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "XQUIKit"
  spec.version      = "0.0.1"
  spec.summary      = "自定义UI组件."
  spec.description  = <<-DESC
  自定义UI组件.
  DESC

  spec.homepage     = "https://github.com/xq0216/XQUIKit"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "laixuefei" => "laixuefei@g7.com.cn" }
  spec.platform     = :ios, "10.0"
  spec.ios.deployment_target = "10.0"
  spec.source       = { :git => "https://github.com/xq0216/XQUIKit.git", :tag => "#{spec.version}" }
  spec.source_files  = "XQUIKit", "Source/**/*.swift"
  spec.requires_arc = true
  spec.swift_version = '4.0'

  spec.default_subspecs = 'Core'

  spec.subspec 'Core' do |ss|
       ss.frameworks = 'UIKit', 'Foundation'
       ss.source_files = 'Source/Common/*.swift'
       ss.ios.resource_bundle = {
           'XQUIKit' => ['Source/Assets/*.xcassets']
       }
   end
  
  # 刷新组件
   spec.subspec 'RefreshBar' do |ss|
       ss.dependency 'XQUIKit/Core'
       ss.source_files = 'Source/RefreshBar/*.swift'
       ss.dependency 'SnapKit', '~> 5.0.0'
   end

end
