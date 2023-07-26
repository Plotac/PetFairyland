//
//  LoginCode.swift
//  PFAccount
//
//  Created by Ja on 2023/7/26.
//

import Foundation

enum LoginCode {
    
    case unknow
    
    case success
    
    case needVerificationCode
    
    case fail(String)
}
