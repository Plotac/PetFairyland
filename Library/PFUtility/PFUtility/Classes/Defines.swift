//
//  Defines.swift
//  PetFairyland
//
//  Created by Ja on 2023/7/25.
//

public struct Screen {
    /// 屏幕宽高
    public static var width: CGFloat { UIScreen.main.bounds.size.width }
    public static var height: CGFloat { UIScreen.main.bounds.size.height }
}

public struct StatusBar {
    /// 状态栏高度
    public static var height: CGFloat = fetchStatusBarHeight()
}

public struct Nav {
    /// 导航栏高度
    public static var height: CGFloat { UIDevice.isiPad() ? 50 : 44 }
}

public struct TabBar {
    /// 导航栏高度
    public static var height: CGFloat { 49 + kBottomSafeMargin }
}


/// 顶部总高度
public let kTopHeight = fetchStatusBarHeight() + Nav.height

/// 顶部安全区高度
public let kTopSafeMargin: CGFloat = fetchSafeAreaInsets().top

/// 底部安全区高度
public let kBottomSafeMargin: CGFloat = fetchSafeAreaInsets().bottom

/// Root VC
public func getRootViewController() -> UIViewController {
    if let delegate = UIApplication.shared.delegate, let window = delegate.window, let rootVC = window?.rootViewController {
        return rootVC
    }
    return UIViewController()
}

/// Root Nav
public func getRootNavigation(index: Int = 0) -> UINavigationController? {
    if let rootTabBarCtrl = getRootViewController() as? UITabBarController {
        return rootTabBarCtrl.viewControllers?[index] as? UINavigationController
    }
    return nil
}

/// Root SubViewController
public func getRootTabBarCtrlSubViewController(index: Int = 0) -> UIViewController? {
    return getRootNavigation(index: index)?.viewControllers.first
}



fileprivate func fetchSafeAreaInsets() -> UIEdgeInsets {
    if #available(iOS 11, *) {
        return UIApplication.shared.delegate?.window??.safeAreaInsets ?? .zero
    }
    return .zero
}

fileprivate func fetchStatusBarHeight() -> CGFloat {
    return max(fetchSafeAreaInsets().top, 20)
}
