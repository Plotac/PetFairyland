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
    
    public var userInfo: UserInfo {
        get {
            let info = UserInfo()
            if let mn = UserDefaults.standard.object(forKey: "PFAccount.mobileNumber") as? String {
                info.mobileNumber = mn
            }
            return info
        }
        set {
            UserDefaults.standard.set(newValue.mobileNumber, forKey: "PFAccount.mobileNumber")
            UserDefaults.standard.synchronize()
        }
    }
    
    public internal(set) var tokenInfo: TokenInfo = TokenInfo()
    
}

public extension PFAccount {
    
    static func login(with request: LoginRequest, completion: PFAccountCompletion?) {
        let login = LoginNavigationController(rootViewController: LoginViewController())
        login.modalPresentationStyle = .fullScreen
        getRootViewController().present(login, animated: true)
    }
}
