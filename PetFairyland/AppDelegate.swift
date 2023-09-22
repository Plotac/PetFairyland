//
//  AppDelegate.swift
//  PetFairyland
//
//  Created by Ja on 2023/7/25.
//

import UIKit
import IQKeyboardManager
import CYLTabBarController

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    public var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = setupRootViewController()
        window?.makeKeyAndVisible()
        
        IQKeyboardManager.shared().isEnabled = true
        
        return true
    }
    
    func setupRootViewController() -> UIViewController {
        let home = PFNavigationController(rootViewController: HomeViewController())
        let mine = PFNavigationController(rootViewController: MineViewController())
        
        let homeAttributes = [CYLTabBarItemTitle: "管理",
                              CYLTabBarItemImage: "tabbar_home_unselect",
                      CYLTabBarItemSelectedImage: "tabbar_home_select"]
        let mineAttributes = [CYLTabBarItemTitle: "我的",
                              CYLTabBarItemImage: "tabbar_mine_unselect",
                      CYLTabBarItemSelectedImage: "tabbar_mine_select"]
        
        let tabbarCtrl = CYLTabBarController(viewControllers: [home, mine],
                                             tabBarItemsAttributes: [homeAttributes, mineAttributes])
        tabbarCtrl.tabBar.backgroundColor = .white
        
        let tabbar = UITabBarItem.appearance()
        tabbar.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: SystemColor.main], for: .selected)
        tabbar.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(hexString: "#33322D")], for: .normal)
        
        return tabbarCtrl
    }

}

