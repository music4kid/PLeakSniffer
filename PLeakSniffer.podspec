#
# Be sure to run `pod lib lint PLeakSniffer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PLeakSniffer'
  s.version          = '0.1.0'
  s.summary          = 'PLeakSniffer should be used as a suggesting tool to detect possible memory leaks'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

#  s.description      = <<-DESC
#we are building controllers most of the time, memory leaks happen within controllers.
#retain cycle stops controller from being released, UIView objects within controllers somehow
#get held by other objects, PLeakSniffer shows its value in such circumstances, it provides
#suggestions, but guarantees nothing. it is your duty to set a breakpoint in the suspicous object's
#dealloc, and reveal the only truth.
#                       DESC

  s.homepage         = 'https://github.com/music4kid/PLeakSniffer'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'gao feng' => '1197902291@qq.com' }
  s.source           = { :git => 'https://github.com/music4kid/PLeakSniffer.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '6.0'

  s.source_files = 'PLeakSniffer/Classes/**/*'
  
  # s.resource_bundles = {
  #   'PLeakSniffer' => ['PLeakSniffer/Assets/*.png']
  # }

  s.public_header_files = 'PLeakSniffer/Classes/PLeakSniffer.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
