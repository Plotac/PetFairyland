//
//  UserInfo.swift
//  PFAccount
//
//  Created by Ja on 2023/7/26.
//

import Foundation

public final class UserInfo: NSObject {
    
    public enum IdentityType: Int {
        case originator = 0, assistant, visitor
    }
    
    public var name: String = ""
    
    public var mobileNumber: String = ""
    
    public var isValid: Bool { !mobileNumber.isEmpty }
    
    public var identity: IdentityType = .visitor
}
