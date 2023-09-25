//
//  String+Common.swift
//  PFAccount
//
//  Created by Ja on 2023/9/20.
//

import Foundation

public extension String {
    
    /// 计算String的宽度
    /// - Parameters:
    ///   - arrStr: 需要计算的字符串
    ///   - size: 字符串size（主要设置字符串的高度）
    /// - Returns: 获取字符串的宽度的方法，用于计算得到一个高度固定的字符串的宽度
    func strWidth(font: UIFont, size: CGSize) -> CGFloat {
        let rect = NSString(string: self).boundingRect(with: CGSize(width: size.width, height: size.height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.width)
    }

    /// 计算String的高度
    /// - Parameters:
    ///   - arrStr: 需要计算的字符串
    ///   - size: 字符串size（主要设置字符串的宽度）
    /// - Returns: 获取字符串的高度的方法，用于计算得到一个宽度固定的字符串的高度
    func strHeight(font: UIFont, size: CGSize) -> CGFloat {
        let rect = NSString(string: self).boundingRect(with: CGSize(width: size.width, height: size.height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.height)
    }

    /// 计算AttributedString的高度
    /// - Parameters:
    ///   - arrStr: 需要计算的字符串
    ///   - size: 字符串size（主要设置字符串的宽度）
    /// - Returns: 获取字符串的高度的方法，用于计算得到一个宽度固定的字符串的高度
    func attStrHeight(arrStr: NSAttributedString, size: CGSize) -> CGFloat {
        let rect = arrStr.boundingRect(with: CGSize.init(width: size.width, height: size.height), options: .usesLineFragmentOrigin, context: nil)
        return ceil(rect.height)
    }

    /// 字符串转Int
    var toInt: Int? {
        return Int(self)
    }

    /// 字符串转Float
    var toFloat: Float? {
        return Float(self)
    }

    /// 字符串转Double
    var toDouble: Double? {
        return Double(self)
    }
    
    /// 字符串转URL
    var toURL: URL? {
        return URL(string: self)
    }

    /// 去除首尾空白字符
    /// - Returns: 处理之后的字符串
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    /// 去除字符串中所有空格
    /// - Returns: 处理之后的字符串
    func withoutEmpty() -> String {
        return trim().replacingOccurrences(of: " ", with: "")
    }
}
