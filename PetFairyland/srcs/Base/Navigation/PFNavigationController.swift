//
//  PFNavigationController.swift
//  PetFairyland
//
//  Created by Ja on 2023/7/25.
//

import UIKit

class PFNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationBar.isTranslucent = false
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(hexString: "#54a0ff")
        appearance.backgroundEffect = nil
        appearance.shadowColor = nil
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 18)]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count != 0 {
            viewController.setupBackBtn()
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}
