//
//  AppColor.swift
//  PFAccount
//
//  Created by Ja on 2023/7/26.
//

public struct SystemColor {
    
    public static var nav: (startColor: UIColor, endColor: UIColor) = (UIColor(hexString: "#FFF2D2"), UIColor(hexString: "#FEF6F9"))
    
    public static var main: UIColor = UIColor(hexString: "#FFC439")
    
    public struct Button {
        public static var enable: UIColor = UIColor(hexString: "#FFC439")
        public static var disable: UIColor = enable.withAlphaComponent(0.5)
    }

}
