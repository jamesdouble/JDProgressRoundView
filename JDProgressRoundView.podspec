Pod::Spec.new do |s|
  s.name             = 'JDProgressRoundView'
  s.version          = '2.1.0'
  s.summary          = 'Progress Meter' 
  s.homepage         = 'https://github.com/jamesdouble/JDProgressRoundView'
  s.license          = { :type => 'Apache License 2.0', :file => 'LICENSE' }
  s.author           = { 'JamesDouble' => 'jameskuo12345@gmail.com' }
  s.source           = { :git => 'https://github.com/jamesdouble/JDProgressRoundView.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '10.0'
  s.source_files = 'ProgressRoundView/JDProgressRoundView/*'
 
end
