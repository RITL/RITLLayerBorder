
Pod::Spec.new do |s|

  s.name         = 'UIView+RITLBorders'
  s.version      = '0.0.1'
  s.summary      = "A custom border for UIView."

  s.homepage     = "https://github.com/RITL/UIView-RITLBorder.git"

  s.license      = 'MIT'

  s.authors       = { "Yuexiaowen" => "yuexiaowen108@gmail.com" }

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/RITL/UIView-RITLBorder.git", :tag => s.version }
  s.source_files = "UIView+RITLBorder/**/*.{h,m}"

  s.frameworks   = 'Foundation', 'UIKit'
  s.requires_arc = true

end
