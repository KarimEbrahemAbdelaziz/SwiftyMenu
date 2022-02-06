#
# Be sure to run `pod lib lint SwiftyMenu.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftyMenu'
  s.version          = '1.0.1'
  s.summary          = 'SwiftyMenu is simple drop down menu for iOS.'

  s.description      = <<-DESC
This drop down is to overcome the loss of usability and user experience due to the UIPickerView.
                       DESC

  s.homepage         = 'https://github.com/KarimEbrahemAbdelaziz/SwiftyMenu'
  s.screenshots = 'https://github.com/KarimEbrahemAbdelaziz/SwiftyMenu/blob/master/Screenshots/3.png?raw=true'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'KarimEbrahemAbdelaziz' => 'karimabdelazizmansour@gmail.com' }
  s.source           = { :git => 'https://github.com/KarimEbrahemAbdelaziz/SwiftyMenu.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/k_ebrahem_'

  s.ios.deployment_target = '10.0'
  s.swift_version = '5.0'

  s.source_files = 'SwiftyMenu/Classes/**/*'
  s.resources = 'SwiftyMenu/Assets/*'
  
  s.dependency 'SnapKit', '~> 5.0.1'
end
