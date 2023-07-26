//
//  PFAccount.swift
//  Alamofire
//
//  Created by Ja on 2023/7/26.
//

import Foundation

public typealias PFAccountCompletion = () -> Void

public final class PFAccount: NSObject {
    
    public static let shared: PFAccount = PFAccount()
    
    public internal(set) var tokenInfo: TokenInfo = TokenInfo()
    
}

public extension PFAccount {
    func login(with request: Request, completion: PFAccountCompletion?) {
        
    }
}
