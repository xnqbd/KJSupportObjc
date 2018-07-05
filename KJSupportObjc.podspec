
Pod::Spec.new do |s|

s.name         = "KJSupportObjc"
s.version      = "1.2.9"
s.summary      = "包含常见的分类、工具，UITableView、UICollectionView的工具等等"

s.homepage     = "https://github.com/xnqbd/KJSupportObjc"


s.license      = "MIT"

s.author             = { "xnqbd" => "2537511854@qq.com" }

s.platform     = :ios
s.platform     = :ios, "8.0"

s.source       = { :git => "https://github.com/xnqbd/KJSupportObjc.git", :tag => "#{s.version}"}

s.source_files  = "KJSupportObjc/KJSupportObjc/Objc/**/*.{h,m}"

# s.public_header_files = "Classes/**/*.h"


s.requires_arc = true

s.dependency "Masonry"

end
