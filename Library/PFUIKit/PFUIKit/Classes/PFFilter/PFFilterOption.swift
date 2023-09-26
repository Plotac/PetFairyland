//
//  PFFilterOption.swift
//  PFUIKit
//
//  Created by Ja on 2023/9/21.
//

import Foundation

public protocol PFFilterOptionType: Equatable {
    
    associatedtype OptionValueType
    
    var associatedValue: OptionValueType { get }
    
    func isEqualTo(_ type: any PFFilterOptionType) -> Bool
}

extension PFFilterOptionType {
//    static func == (lhs: any PFFilterOptionType, rhs: any PFFilterOptionType) -> Bool {
//        return lhs.value as! (any PFFilterOptionType) == rhs.value as! (any PFFilterOptionType)
//    }
}

public class PFFilterOption {
    
    public var title: String = ""
    
    public var type: any PFFilterOptionType
    
    public var selected: Bool = false
    
    /// 是否是重置属性，当该属性为true时，不参与筛选
    public var isResetAttribute: Bool = false
    
    public init(title: String, type: any PFFilterOptionType, selected: Bool, isResetAttribute: Bool = false) {
        self.title = title
        self.type = type
        self.selected = selected
        self.isResetAttribute = isResetAttribute
    }
}
