#
# Be sure to run `pod lib lint PFUIKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PFUIKit'
  s.version          = '0.1.0'
  s.summary          = 'A short description of PFUIKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/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/PFUIKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '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' => 'jinan@junying-tech.com' }
  s.source           = { :git => 'https://github.com/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/PFUIKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  
  s.source_files = 'PFUIKit/Classes/**/*'
  s.ios.deployment_target = '13.0'
  s.swift_version = '5.0'
  
  s.dependency 'SnapKit'
  s.dependency 'PFUtility'
  s.dependency 'JXSegmentedView'
  s.dependency 'JXPagingView/Paging'
  s.dependency 'MJRefresh'
  
end
