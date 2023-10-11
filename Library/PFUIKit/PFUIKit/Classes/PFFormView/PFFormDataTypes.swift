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
    
    public var showHeader: Bool = true
    
    public var headerHeight: CGFloat = 30
    
    public var formModels: [PFFormModel]?
}

public class PFFormModel: NSObject {
    
    public enum RightViewMode: Equatable {
        case unknown
        
        case textfield(placeholder: String?, defaultText: String?)
        case textView(placeholder: String?, defaultText: String?)
        case `switch`
        case picker(defaultText: String?)
        case options(_ optionTitles: [String])
        case custom(_ customView: UIView)
        
        public var rawValue: Int {
            get {
                switch self {
                case .unknown: return 999
                case .textfield: return 0
                case .textView: return 1
                case .switch: return 2
                case .picker: return 3
                case .options(let _): return 4
                case .custom(let _): return 5
                    
                }
            }
        }
        
        public var placeholder: String? {
            get {
                switch self {
                case let .textfield(placeholder, _):
                    return placeholder
                case let .textView(placeholder, _):
                    return placeholder
                default: return nil
                }
            }
        }
        
        public var defaultText: String? {
            get {
                switch self {
                case let .textfield(_, defaultText):
                    return defaultText
                case let .textView(_, defaultText):
                    return defaultText
                case let .picker(defaultText):
                    return defaultText
                default: return nil
                }
            }
        }
        
        public static func == (lhs: RightViewMode, rhs: RightViewMode) -> Bool {
            return lhs.rawValue == rhs.rawValue
        }
    }
    
    public var type: PFFormType!
    
    public var rightViewMode: RightViewMode = .unknown
    
    public var rightViewLeftOffset: CGFloat = 200
    
    public var rowHeight: CGFloat = 50.0
    
    public var title: String = ""
    
    public var isNecessary: Bool = false
    
    public var showSeparatorLine: Bool = true
    
    public var subFormModels: [PFFormModel]?
    
    internal var isOriginalRowHeight: Bool { rowHeight == 50.0 }
}
