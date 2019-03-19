

Pod::Spec.new do |s|
  s.name             = 'YPMenuController'
  s.version          = '0.1.0'
  s.summary          = 'Implement the custom "UIMenuController" function.'



  s.description      = <<-DESC
  Implement the custom "UIMenuController" function.
                       DESC

  s.homepage         = 'https://github.com/liuyaping/YPMenuController'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liuyaping' => 'lypJTD@163.com' }
  s.source           = { :git => 'https://github.com/liuyaping/YPMenuController.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'YPMenuController/Classes/**/*'
 
  s.public_header_files = 'YPMenuController/Classes/**/*.h'
  s.frameworks = 'UIKit', 'Foundation'

end
