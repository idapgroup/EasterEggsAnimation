Pod::Spec.new do |s|
  s.name      = "EasterEggsAnimation"
  s.version   = "1.0.0"
  s.swift_version = "5.5"
  s.summary   = "EasterEggsAnimation is a beautiful endless animation."
  s.description  = "EasterEggsAnimation is a convenient way to decorate the entire screen of your application or a separate view by adding beautiful endless animation."
  s.homepage  = "https://github.com/idapgroup/EasterEggsAnimation"
  s.license   = { :type => "MIT", :file => "LICENSE" }
  s.author    = { "IDAP Group" => "hello@idapgroup.com" }
  s.source    = { :git => "https://github.com/idapgroup/EasterEggsAnimation.git",
                  :tag => s.version.to_s }

  # Platform setup
  s.requires_arc          = true
  s.ios.deployment_target = '15.0'

  # Preserve the layout of headers in the Module directory
  s.header_mappings_dir   = 'Source'
  s.source_files          = 'Source/**/*.{swift,h,m,c,cpp}'
end
