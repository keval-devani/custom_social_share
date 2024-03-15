#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint custom_social_share.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'custom_social_share'
  s.version          = '0.0.1'
  s.summary          = 'Flutter Plugin for sharing contents to particular social media app or all.'
  s.description      = <<-DESC
Flutter Plugin for sharing contents to particular social media app or all.
                       DESC
  s.homepage         = 'https://github.com/keval-devani/custom_social_share'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'KD' => 'kevaldevani101@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
