//
//  PFNavigationController.swift
//  PFUIKit
//
//  Created by Ja on 2023/7/25.
//

import Foundation

open class PFNavigationController: UINavigationController {
    
    public enum Style {
        case `default`
        case full(color: UIColor)
        case gradient(gradientColors: (startColor: UIColor, endColor: UIColor))
    }
    
    public private(set) var style: PFNavigationController.Style = .default
    
    public init(rootViewController: UIViewController, style: PFNavigationController.Style = .default) {
        self.style = style
        
        super.init(rootViewController: rootViewController)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = SystemColor.viewBackgroundColor
        
        navigationBar.isTranslucent = false
        
        var _color: UIColor? = nil
        var _colors: (UIColor, UIColor)? = nil
        switch style {
        case .default: break
        case .full(let color):
            _color = color
        case .gradient(let gradientColors):
            _colors = gradientColors
        }
        if let _color = _color {
            resetNavigationBarAppearance(color: _color)
        } else if let _colors = _colors {
            resetNavigationBarAppearance(gradientColors: _colors)
        } else {
            resetNavigationBarAppearance()
        }
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
