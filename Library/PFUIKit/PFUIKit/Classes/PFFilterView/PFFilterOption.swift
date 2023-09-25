//
//  PFFilterOption.swift
//  PFUIKit
//
//  Created by Ja on 2023/9/21.
//

import Foundation

public protocol OptionType {
//    associatedtype EnumType
//    static var allCases: [EnumType] { get }
}

open class PFFilterOption {
    
    open var title: String = ""
    
    open var type: OptionType
    
    public required init(title: String, type: OptionType) {
        self.title = title
        self.type = type
    }
}

enum LifeOptionType: OptionType {
    case typeB
    case typeC
    
//    static var allCases: [ServiceOptionType] {
//        return [.typeA, .typeB]
//    }
}

enum ServiceOptionType: OptionType {
    case typeA
    case typeB
    
//    static var allCases: [ServiceOptionType] {
//        return [.typeA, .typeB]
//    }
}
