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
  pod 'IQKeyboardManager'
  pod 'CYLTabBarController'
  
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

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
            end
        end
    end
end
