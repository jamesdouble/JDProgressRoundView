Pod::Spec.new do |s|
  s.name             = 'JDMailBox'
  s.version          = '1.0.0'
  s.summary          = 'Send Mail Animation'
  s.description      = <<-DESC
JDMailBox is basically a MFMailComposeViewController 📬 , but I think it will be more interesting with an animation..
                       DESC
 
  s.homepage         = 'https://github.com/jamesdouble/JDMailBox'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'JamesDouble' => 'jameskuo12345@gmail.com' }
  s.source           = { :git => 'https://github.com/jamesdouble/JDMailBox.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '8.0'
  s.source_files = 'JDMailBox/JDMailBox/*'
 
end
