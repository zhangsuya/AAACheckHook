Pod::Spec.new do |s|

  s.name         = 'AAACheckHook'
  s.version      = '0.1.0'
  s.license      = 'MIT'
  s.homepage     = 'https://github.com/zhangsuya'
  s.authors      = {'suya' => 'zhangsuya@peilian.cn'}
  s.summary      = 'AAACheckHook'
  s.pod_target_xcconfig = { 'VALID_ARCHS' => 'x86_64 armv7 arm64' }
  s.platform     =  :ios, '8.0'
  s.source       =  { git: 'https://github.com/zhangsuya/AAACheckHook.git', :tag => s.version }
  s.requires_arc = true
  
  s.source_files = 'Source/*/*.{h,m}'
  s.dependency 'fishhook'


  
end
