//
//  UIColor+Common.swift
//  PetFairyland
//
//  Created by Ja on 2023/7/25.
//

import UIKit

extension UIColor {
    
    class func randomColor() -> UIColor {
        return UIColor(red: CGFloat(arc4random()%256)/255.0, green: CGFloat(arc4random()%256)/255.0, blue: CGFloat(arc4random()%256)/255.0, alpha: 1)
    }
    
    convenience init(hexString:String, alpha: CGFloat = 1.0) {
        var cString = hexString.uppercased().trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        let length = (cString as NSString).length
        if (length < 6 || length > 7 || (!cString.hasPrefix("#") && length == 7)) {
            self.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
            return
        }
        
        if cString.hasPrefix("#") {
            cString = (cString as NSString).substring(from: 1)
        }
        
        var range = NSRange()
        range.location = 0
        range.length = 2
        
        let rString = (cString as NSString).substring(with: range)
        
        range.location = 2
        let gString = (cString as NSString).substring(with: range)
        
        range.location = 4
        let bString = (cString as NSString).substring(with: range)
        
        var r: UInt64 = 0, g: UInt64 = 0, b: UInt64 = 0
        
        Scanner(string: rString).scanHexInt64(&r)
        Scanner(string: gString).scanHexInt64(&g)
        Scanner(string: bString).scanHexInt64(&b)
        self.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: alpha)
    }
}
