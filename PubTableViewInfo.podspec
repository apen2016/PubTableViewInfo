#
# Be sure to run `pod lib lint PubTableViewInfo.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PubTableViewInfo'
  s.version          = '0.1.5'
  s.summary          = 'tableView布局封装'
  s.swift_version = '5.0'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  简单易用的页面布局库，任何UI控件皆cell。
                       DESC

  s.homepage         = 'https://github.com/apen2016/PubTableViewInfo'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'linqipeng' => '526320441@qq.com' }
  s.source           = { :git => 'https://github.com/apen2016/PubTableViewInfo.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'PubTableViewInfo/Classes/**/*'
  
  # s.resource_bundles = {
  #   'PubTableViewInfo' => ['PubTableViewInfo/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'SnapKit','~>5.6.0'
   
end
