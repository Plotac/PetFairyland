platform :ios, '14.0'
source 'https://cdn.cocoapods.org/'
inhibit_all_warnings!

def openPods
  
  pod "MBProgressHUD"
  pod 'Alamofire'
  pod 'SnapKit'
  pod 'ObjectMapper'
  pod 'Kingfisher', '~> 7.0'
  pod "FDFullscreenPopGesture"
  
end

def localPods
  pod 'PFUIKit',   :path => 'Library/PFUIKit'
  pod 'PFUtility',   :path => 'Library/PFUtility'
  pod 'PFNetwork', :path => 'Library/PFNetwork'
  pod 'PFAccount', :path => 'Library/PFAccount'
end

target 'PetFairyland' do
  use_frameworks!
  
  openPods
  localPods

end
