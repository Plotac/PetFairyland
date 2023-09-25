//
//  UIButton+Common.swift
//  PFUIKit
//
//  Created by Ja on 2023/9/25.
//

import Foundation

public enum ButtonImagePosition {
    case top, bottom, left, right
}

public extension UIButton {
    
    /// 设置按钮的图片的位置
    /// - Parameters:
    ///   - position: 图片位置
    ///   - space: 和titleLabel的间距
    func setImagePosition(position: ButtonImagePosition, space: CGFloat)  {
        
        guard let imgView = imageView else {
            fatalError("UIButton fatalError: imageView can't be nil when you use 'setImagePosition' function ")
            return
        }
        
        guard let titleLab = titleLabel else {
            fatalError("UIButton fatalError: titleLabel can't be nil when you use 'setImagePosition' function ")
            return
        }
        
        guard contentHorizontalAlignment == .center else {
            fatalError("UIButton fatalError: contentHorizontalAlignment must be center when you use 'setImagePosition' function ")
            return
        }
        
        let imageWith: CGFloat = imgView.intrinsicContentSize.width
        let imageHeight: CGFloat = imgView.intrinsicContentSize.height
        
        var labelWidth: CGFloat = titleLab.intrinsicContentSize.width
        var labelHeight: CGFloat = titleLab.intrinsicContentSize.height
        
        var imageEdgeInsets: UIEdgeInsets = UIEdgeInsets()
        var labelEdgeInsets: UIEdgeInsets = UIEdgeInsets()
        
        switch position {
        case .top:
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight - space / 2.0, left: 0, bottom: 0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWith, bottom: -imageHeight-space/2.0, right: 0)
        case .left:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -space / 2.0, bottom: 0, right: space / 2.0)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: space / 2.0, bottom: 0, right: -space / 2.0)
        case .bottom:
            imageEdgeInsets = UIEdgeInsets(top: 0, left:0, bottom: -labelHeight - space / 2.0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: -imageHeight - space / 2.0, left: -imageWith, bottom: 0, right: 0)
        case .right:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth + space / 2.0, bottom: 0, right: -labelWidth - space / 2.0)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWith - space / 2.0, bottom: 0, right: imageWith + space/2.0)
        }
        
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
    }
    
}
