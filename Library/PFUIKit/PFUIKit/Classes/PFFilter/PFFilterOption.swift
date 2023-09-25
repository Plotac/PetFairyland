//
//  PFFilterOption.swift
//  PFUIKit
//
//  Created by Ja on 2023/9/21.
//

import Foundation

public struct PFFilterOption {
    
    public var title: String = ""
    
    public var selected: Bool = false
    
    public init(title: String, selected: Bool) {
        self.title = title
        self.selected = selected
    }
}
