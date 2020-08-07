#
# Be sure to run `pod lib lint DuitkuSDkIos.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DuitkuSDkIos'
  s.version          = '0.10.0'
  s.summary          = 'duitku sdk is lib for integration payment on your apps ios.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'duitku sdk is lib for simple integration payment on your apps ios'

  s.homepage         = 'https://github.com/bambangm88/DuitkuSDkIos'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'bambangm88' => 'bambangm88@gmail.com' }
  s.source           = { :git => 'https://github.com/bambangm88/DuitkuSDkIos.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.swift_version = '4.0'
  s.ios.deployment_target = '11.0'

  s.source_files = 'DuitkuSDkIos/Classes/**/*'
  
  
  s.resource_bundles = {
     'Animated' => ['DuitkuSDkIos/Resources/*/**']
  }


  

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
