//
//  AppDelegate.swift
//  PetFairyland
//
//  Created by Ja on 2023/7/25.
//

import UIKit
import IQKeyboardManager

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    public var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = PFNavigationController(rootViewController: HomeViewController())
        window?.makeKeyAndVisible()
        
        IQKeyboardManager.shared().isEnabled = true
        
        return true
    }

}

