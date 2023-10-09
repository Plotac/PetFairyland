//
//  PFBaseTableViewCell.swift
//  PFUIKit
//
//  Created by Ja on 2023/10/9.
//

import Foundation

open class PFBaseTableViewCell: UITableViewCell {
    
    // cell的左右边距
    open var cellMargin: CGFloat { 0 }
    
    // 若设置改属性，cell的高度需要在设计图上的高度上再加上该属性的值，并且注意tableview的底部约束
    open var lineSpacing: CGFloat { 0 }
    
    open override var frame: CGRect {
        get {
            return super.frame
        }
        set {
            var frame = newValue
            
            frame.origin.x += cellMargin
            frame.size.width -= 2 * cellMargin
            
            frame.size.height -= lineSpacing
            
            super.frame = frame
        }
    }
}
