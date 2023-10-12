//
//  PFPickerSectionModel.swift
//  PFUIKit
//
//  Created by Ja on 2023/10/12.
//

import Foundation

public class PFPickerSectionModel: NSObject {
    
    public var showHeaderView: Bool = false
    
    public var headerHeight: CGFloat = 0
    
    public var headerView: UIView?
    
    public var showFooterView: Bool = false
    
    public var footerHeight: CGFloat = 0
    
    public var footerView: UIView?
    
    public var rowHeight: CGFloat = 50
    
    public var data: [Any]?
}
