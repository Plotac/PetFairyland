//
//  UserInfo.swift
//  PFAccount
//
//  Created by Ja on 2023/7/26.
//

import Foundation

public final class UserInfo: NSObject {
    
    public var name: String = ""
    
    public var mobileNumber: String = ""
    
    public var isValid: Bool { !name.isEmpty && !mobileNumber.isEmpty }
}
