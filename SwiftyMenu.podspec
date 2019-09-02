#
# Be sure to run `pod lib lint SwiftyMenu.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftyMenu'
  s.version          = '0.5.2'
  s.summary          = 'SwiftyMenu is simple drop down menu for iOS.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This drop down is to overcome the loss of usability and user experience due to the UIPickerView.
                       DESC

  s.homepage         = 'https://github.com/KarimEbrahemAbdelaziz/SwiftyMenu'
  s.screenshots = 'https://github.com/KarimEbrahemAbdelaziz/SwiftyMenu/blob/master/Screenshots/3.png?raw=true'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'KarimEbrahemAbdelaziz' => 'karimabdelazizmansour@gmail.com' }
  s.source           = { :git => 'https://github.com/KarimEbrahemAbdelaziz/SwiftyMenu.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/KarimEbrahem512'

  s.ios.deployment_target = '10.0'
  s.swift_version = '4.2'

  s.source_files = 'SwiftyMenu/Classes/**/*'
  s.resources = 'SwiftyMenu/Assets/*'
  
  s.dependency 'SnapKit', '~> 4.2.0'
  
  # s.resource_bundles = {
  #   'SwiftyMenu' => ['SwiftyMenu/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
end
