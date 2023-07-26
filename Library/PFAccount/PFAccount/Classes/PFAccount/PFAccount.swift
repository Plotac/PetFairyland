//
//  PFAccount.swift
//  PFAccount
//
//  Created by Ja on 2023/7/26.
//

import PFUtility

public typealias PFAccountCompletion = () -> Void

public final class PFAccount: NSObject {
    
    public static let shared: PFAccount = PFAccount()
    
    public internal(set) var userInfo:  UserInfo = UserInfo()
    
    public internal(set) var tokenInfo: TokenInfo = TokenInfo()
    
}

public extension PFAccount {
    
    static func login(with request: LoginRequest, completion: PFAccountCompletion?) {
        let login = LoginNavigationController(rootViewController: LoginViewController())
        login.modalPresentationStyle = .fullScreen
        getRootViewController().present(login, animated: true)
    }
}
