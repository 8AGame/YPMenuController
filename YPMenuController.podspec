

Pod::Spec.new do |s|
  s.name             = 'YPMenuController'
  s.version          = '0.0.4'
  s.summary          = 'Implement the custom "UIMenuController" function.'



  s.description      = <<-DESC
  Implement the custom "UIMenuController" function.
                       DESC

  s.homepage         = 'https://github.com/LYPDoit/YPMenuController'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'LYPDoit' => 'lypJTD@163.com' }
  s.source           = { :git => 'https://github.com/LYPDoit/YPMenuController.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'YPMenuController/Classes/**/*'
 
  s.public_header_files = 'YPMenuController/Classes/**/*.h'
  s.frameworks = 'UIKit', 'Foundation'

end
