//
//  PFNavigationController.swift
//  PFUIKit
//
//  Created by Ja on 2023/7/25.
//

import PFUtility

open class PFNavigationController: UINavigationController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = SystemColor.viewBackgroundColor
        
        navigationBar.isTranslucent = false
        resetNavigationBarAppearance()
    }
    
    open override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count != 0 {
            viewController.setupBackBtn()
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}
