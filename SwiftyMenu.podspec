#
# Be sure to run `pod lib lint SwiftyMenu.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftyMenu'
  s.version          = '0.1.0'
  s.summary          = 'A short description of SwiftyMenu.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This drop down is to overcome the loss of usability and user experience due to the UIPickerView.
                       DESC

  s.homepage         = 'https://github.com/KarimEbrahemAbdelaziz/SwiftyMenu'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'KarimEbrahemAbdelaziz' => 'karimabdelazizmansour@gmail.com' }
  s.source           = { :git => 'https://github.com/KarimEbrahemAbdelaziz/SwiftyMenu.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/KarimEbrahem512'

  s.ios.deployment_target = '8.0'

  s.source_files = 'SwiftyMenu/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SwiftyMenu' => ['SwiftyMenu/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
