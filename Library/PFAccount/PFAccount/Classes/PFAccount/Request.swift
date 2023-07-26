//
//  Request.swift
//  PFAccount
//
//  Created by Ja on 2023/7/26.
//

import Foundation

public enum LoginType {
    /// 短信登录
    case sms
    /// 密码登录
    case password
}

public protocol LoginRequest {
    var type: LoginType { get }
    var mobileNumber: String { get set }
    
    func resume()
}

extension LoginRequest {
    public func resume() {}
}

public struct SMSRequest: LoginRequest {
    public let type: LoginType = .sms
    public var mobileNumber: String = ""
    
    public init(mobileNumber: String) {
        self.mobileNumber = mobileNumber
    }
}

public struct PasswordRequest: LoginRequest {
    public let type: LoginType = .password
    public var mobileNumber: String = ""
    public var password: String = ""
    
    public init(mobileNumber: String, password: String) {
        self.mobileNumber = mobileNumber
        self.password = password
    }
}


