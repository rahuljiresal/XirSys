Pod::Spec.new do |s|
  s.name             = "xirsys"
  s.version          = "0.1.0"
  s.summary          = "An Objective-C client for the XirSys API."
  s.homepage         = "https://github.com/samsymonss/XirSys"
  s.license          = 'MIT'
  s.author           = { "Sam Symons" => "sam@samsymons.com" }
  s.source           = { :git => "https://github.com/samsymons/XirSys.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/sam_symons'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'

  s.public_header_files = 'Pod/Classes/**/*.h'
end
