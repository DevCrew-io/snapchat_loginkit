#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint snapchat_loginkit.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'snapchat_loginkit'
  s.version          = '1.0.0'
  s.summary          = 'Flutter plugin for integrating Snapchat LoginKit, providing a seamless authentication experience in Flutter apps.'
  s.description      = <<-DESC
Flutter plugin for integrating Snapchat LoginKit, providing a seamless authentication experience in Flutter apps.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'DevCrew I/O' => 'https://devcrew.io' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

  s.dependency 'SnapSDK/SCSDKLoginKit', '~> 2.5.0'
end
