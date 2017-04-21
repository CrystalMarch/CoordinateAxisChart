Pod::Spec.new do |s|

  s.name         = "CoordinateAxisChart"
  s.version      = "0.0.2"
  s.summary      = "A short description of CoordinateAxisChart."
  s.homepage     = "https://github.com/CrystalMarch/CoordinateAxisChart"
  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "Crystal" => "zhuhuiping@shinetechchina.com" }
  s.platform     = :ios
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/CrystalMarch/CoordinateAxisChart.git", :tag => "0.0.2" }
  s.source_files  = "CoordinateAxisChart/CoordinateAxisChart/*.swift", "CoordinateAxisChart/CoordinateAxisChart/**/*.swift"
  s.exclude_files = "Classes/Exclude"
  s.frameworks = "Foundation", "UIKit"
   s.requires_arc = true
end
