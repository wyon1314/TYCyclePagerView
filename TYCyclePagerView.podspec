Pod::Spec.new do |s|
# 名称 使用的时候pod search [name]
s.name = "TYCyclePagerView"
# 代码库的版本
s.version = "1.2.0"
# 简介
s.summary = "a simple and usefull cycle pager view ,and auto scroll banner view,include pageControl for iOS,support Objective-C and swift"
# 主页
s.homepage = "https://github.com/12207480/TYCyclePagerView"
# 许可证书类型，要和仓库的LICENSE 的类型一致
s.license = { :type => 'MIT', :file => 'LICENSE' }
# 作者名称 和 邮箱
s.author = { "tany" => "122074809@qq.com" }
# 作者主页 s.social_media_url =""
# 代码库最低支持的版本
s.platform = :ios, "11.0"
# 代码的Clone 地址 和 tag 版本
s.source = { :git => "https://github.com/12207480/TYCyclePagerView.git", :tag => s.version.to_s }
# 如果使用pod 需要导入哪些资源
s.source_files = "TYCyclePagerViewDemo/TYCyclePagerView/**/*.{h,m}"
# s.resources = "**/*/*.bundle"
# 框架是否使用的ARC
s.requires_arc = true
end
