//
//  AppColor.swift
//  PFAccount
//
//  Created by Ja on 2023/7/26.
//

public struct SystemColor {
    
    public static var nav: (startColor: UIColor, endColor: UIColor) = (UIColor(hexString: "#FFF2D2"), UIColor(hexString: "#FEF6F9"))
    
    public static var main: UIColor = UIColor(hexString: "#FFC439")
    
    public static var separator: UIColor = UIColor(hexString: "#EDEDED")
    
    public static var mask: UIColor = UIColor(hexString: "#000000", alpha: 0.5)
    
    public static var viewBackgroundColor: UIColor = UIColor(hexString: "#F9FAF9")
    
    public struct Button {
        public static var enable: UIColor = main
        public static var disable: UIColor = enable.withAlphaComponent(0.5)
    }

}
