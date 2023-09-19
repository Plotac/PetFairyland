//
//  UIFont+Common.swift
//  Alamofire
//
//  Created by Ja on 2023/9/19.
//

import Foundation

public extension UIFont {
    
    public enum PingFangStyle {
        case regular, semibold, medium
    }
    
    open class func pingfang(style: PingFangStyle, size: CGFloat) -> UIFont {
        switch style {
        case .regular:
            return UIFont(name: "PingFangSC-Regular", size: size)!
        case .semibold:
            return UIFont(name: "PingFangSC-Semibold", size: size)!
        case .medium:
            return UIFont(name: "PingFangSC-Medium", size: size)!
        }
    }
}
