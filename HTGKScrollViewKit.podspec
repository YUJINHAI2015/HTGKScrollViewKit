#
# Be sure to run `pod lib lint HTGKScrollViewKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HTGKScrollViewKit'
  s.version          = '0.3.0'
  s.summary          = 'HTGKScrollViewKit 一个简单的Scrollview框架'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
需要有两个代理方法，delegate和datasource,传入的数据要支持ItemModelProtocol,传入的UView要支持ItemViewProtocol
                       DESC

  s.homepage         = 'https://github.com/YUJINHAI2015/HTGKScrollViewKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'YUJINHAI2015' => '15088132368@163.com' }
  s.source           = { :git => 'https://github.com/YUJINHAI2015/HTGKScrollViewKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'HTGKScrollViewKit/Classes/**/*'
  
  # s.resource_bundles = {
  #   'HTGKScrollViewKit' => ['HTGKScrollViewKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.swift_version = '5.0'
  s.dependency 'SnapKit', '~> 4.2.0'

end
