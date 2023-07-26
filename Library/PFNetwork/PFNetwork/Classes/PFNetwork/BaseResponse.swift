//
//  BaseResponse.swift
//  PFNetwork
//
//  Created by Ja on 2023/7/26.
//

import Foundation
import ObjectMapper

public class BaseResponse: NSObject, Mappable {
    
    var code: Int = 0
    var message: String = ""
    var result: Any?
    
    override required init() {}
    required public init?(map: Map) {}
    
    public func mapping(map: Map) {
        
    }
}
