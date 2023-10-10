//
//  PFFormDataTypes.swift
//  PFUIKit
//
//  Created by Ja on 2023/8/1.
//

import Foundation

public protocol PFFormType {
    var typeDescription: String { get }
}

extension PFFormType {
    var typeDescription: String { "unknown" }
}

public class PFFormSectionModel: NSObject {
    public var title: String = ""
    
    public var models: [PFFormModel]?
}

public class PFFormModel: NSObject {
    
    public enum RightViewMode {
        case textfield
        case textView
        case `switch`
        case picker
    }
    
    public var type: PFFormType!
    
    public var rightViewMode: RightViewMode = .textfield
    
    public var rightViewLeftOffset: CGFloat = 130
    
    public var rowHeight: CGFloat = 50.0
    
    public var title: String = ""
    
    public var placeholder: String = ""
    
    public var isNecessary: Bool = false
    
    public var showSeparatorLine: Bool = false
    
    internal var isOriginalRowHeight: Bool { rowHeight == 50.0 }
}
