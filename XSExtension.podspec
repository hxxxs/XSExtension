
Pod::Spec.new do |s|
  s.name             = 'XSExtension'
  s.version          = '1.1.5'
  s.summary          = 'Swift 方法拓展'

  s.homepage         = 'https://github.com/hxxxs/XSExtension'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Cedar' => 'lychae@foxmail.com' }
  s.source           = { :git => 'https://github.com/hxxxs/XSExtension.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'XSExtension/Classes/**/*'
  s.swift_version = '4.2'

end
