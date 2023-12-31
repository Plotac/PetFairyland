//
//  ProductManageModel.swift
//  PetFairyland
//
//  Created by Ja on 2023/10/9.
//

import Foundation

class ProductManageModel: NSObject {
    
    enum Status: Int {
    case online = 0, offline
    }
    
    enum MembershipType: Int {
    case price = 0, discount
    }
    
    var name: String = ""
    
    var price: CGFloat = 0
    
    var membershipPrice: CGFloat = 0
    
    var membershipType: ProductManageModel.MembershipType = .price
    
    var serviceTime: CGFloat = 0
    
    var salesVolume: Int = 0
    
    var status: ProductManageModel.Status = .online
}
