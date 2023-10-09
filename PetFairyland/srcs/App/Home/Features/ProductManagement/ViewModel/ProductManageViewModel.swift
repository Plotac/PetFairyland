//
//  ProductManageViewModel.swift
//  PetFairyland
//
//  Created by Ja on 2023/10/9.
//

import Foundation

class ProductManageViewModel: NSObject {
    
    var productModels: [ProductManageModel] = []
    
    var onlineModels: [ProductManageModel] {
        productModels.filter { $0.status == .online }
    }
    
    var offlineModels: [ProductManageModel] {
        productModels.filter { $0.status == .offline }
    }
    
    override init() {
        super.init()
        productModels = generateTestModels()
    }
    
    func generateTestModels() -> [ProductManageModel] {
        var models: [ProductManageModel] = []
        
        let productNames = ["猫咪洗护套餐", "猫咪绝育套餐", "猫咪疫苗三联", "狗狗洗护套餐", "狗狗洁牙套餐", "猫咪洗澡服务", "猫咪体检"]
        productNames.forEach { name in
            let model = ProductManageModel()
            model.name = name
            model.price = min(100, CGFloat(arc4random() % 500))
            model.membershipPrice = min(80, CGFloat(arc4random() % 500))
            model.membershipType = ProductManageModel.MembershipType.init(rawValue: Int(arc4random() % 2)) ?? .price
            model.serviceTime = 0.5
            model.salesVolume = Int(arc4random() % 1000)
            model.status = ProductManageModel.Status.init(rawValue: Int(arc4random() % 2)) ?? .online
            models.append(model)
        }
        
        return models
    }
}
