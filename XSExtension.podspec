
Pod::Spec.new do |s|
  s.name             = 'XSExtension'
  s.version          = '3.0.3'
  s.summary          = 'Swift 方法拓展'

  s.homepage         = 'https://github.com/hxxxs'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Cedar' => 'lychae@foxmail.com' }
  s.source           = { :git => 'https://github.com/hxxxs/XSExtension.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'Sources/XSExtension/*'
  s.swift_version = '5.0'

end
