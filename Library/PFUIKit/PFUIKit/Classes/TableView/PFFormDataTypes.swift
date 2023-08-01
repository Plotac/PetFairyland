//
//  PFFormDataTypes.swift
//  PFUIKit
//
//  Created by Ja on 2023/8/1.
//

import Foundation

public protocol PFFormType {
    var typeName: String { get }
}

extension PFFormType {
    var typeName: String { "unknown" }
}

open class PFFormModel: NSObject {
    
    open var type: PFFormType!
    
    public enum EditMode {
        case textfield, textView
    }
    
    open var editMode: EditMode = .textfield
    
    open var editViewLeftOffset: CGFloat = 130
    
    open var rowHeight: CGFloat = 50.0
    
    open var title: String = ""
    
    open var placeholder: String = ""
    
    open var isNecessary: Bool = false
    
    open var showSeparatorLine: Bool = false
    
    internal var isOriginalRowHeight: Bool { rowHeight == 50.0 }
}
