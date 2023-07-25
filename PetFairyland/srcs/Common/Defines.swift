//
//  Defines.swift
//  PetFairyland
//
//  Created by Ja on 2023/7/25.
//

import SnapKit
import Alamofire
import Kingfisher

struct Screen {
    /// 屏幕宽高
    static var width: CGFloat { UIScreen.main.bounds.size.width }
    static var height: CGFloat { UIScreen.main.bounds.size.height }
}

struct StatusBar {
    /// 状态栏高度
    static var height: CGFloat = fetchStatusBarHeight()
}

struct Nav {
    /// 导航栏高度
    static var height: CGFloat { UIDevice.isiPad() ? 50 : 44 }
}


/// 顶部总高度
let kTopHeight = fetchStatusBarHeight() + Nav.height

/// 顶部安全区高度
let kTopSafeMargin: CGFloat = fetchSafeAreaInsets().top

/// 底部安全区高度
let kBottomSafeMargin: CGFloat = fetchSafeAreaInsets().bottom


fileprivate func fetchSafeAreaInsets() -> UIEdgeInsets {
    if #available(iOS 11, *) {
        return UIApplication.shared.delegate?.window??.safeAreaInsets ?? .zero
    }
    return .zero
}

fileprivate func fetchStatusBarHeight() -> CGFloat {
    return max(fetchSafeAreaInsets().top, 20)
}
