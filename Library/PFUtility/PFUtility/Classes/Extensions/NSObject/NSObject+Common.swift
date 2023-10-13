//
//  NSObject+Common.swift
//  PetFairyland
//
//  Created by Ja on 2023/7/25.
//

import Foundation

public extension NSObject {
    class func reuseIdentity() -> String {
        return NSStringFromClass(self.classForCoder()) + self.description() + ".reuseIdentity"
    }
}
