//
//  ProductProcessViewModel.swift
//  PetFairyland
//
//  Created by Ja on 2023/10/10.
//

import Foundation

class ProductProcessViewModel: NSObject {
        
    enum FormType: PFFormType {
        case productName
        case productPrice
        case memberBenefits
        case discountCoupon
        case serviceTime
        case productImage
        case suitablePets
        case productDetail
                
        var typeDescription: String {
            let prefix: String = "ProductProcessViewModel.FormType."
            switch self {
            case .productName:
                return prefix + "productName"
            case .productPrice:
                return prefix + "productPrice"
            case .memberBenefits:
                return prefix + "memberBenefits"
            case .discountCoupon:
                return prefix + "discountCoupon"
            case .serviceTime:
                return prefix + "serviceTime"
            case .productImage:
                return prefix + "productImage"
            case .suitablePets:
                return prefix + "suitablePets"
            case .productDetail:
                return prefix + "productDetail"
            }
        }
        
        enum SubType {
            case uniformMembershipPrice
            var typeDescription: String {
                let prefix: String = "ProductProcessViewModel.FormType.SubType"
                switch self {
                case .uniformMembershipPrice:
                    return prefix + "uniformMembershipPrice"
                }
            }
        }
    }
    
    var formSectionModels: [PFFormSectionModel] = []
    
    var formView: PFFormView!
    
    override init() {
        super.init()
        formSectionModels = generateSectionModels()
        buildUI()
    }
    
}

extension ProductProcessViewModel {
    func generateSectionModels() -> [PFFormSectionModel] {
        let info = PFFormSectionModel()
        info.title = "商品信息"
        
        let productName = PFFormModel()
        productName.type = ProductProcessViewModel.FormType.productName
        productName.title = "商品名称"
        productName.isNecessary = true
        productName.rightViewMode = .textfield(placeholder: "请输入商品名称", defaultText: nil)
        
        let productPrice = PFFormModel()
        productPrice.type = ProductProcessViewModel.FormType.productPrice
        productPrice.title = "商品价格"
        productPrice.isNecessary = true
        productPrice.rightViewMode = .textfield(placeholder: "请输入商品价格", defaultText: nil)
        
        let memberBenefits = PFFormModel()
        memberBenefits.type = ProductProcessViewModel.FormType.memberBenefits
        memberBenefits.title = "会员优惠"
        memberBenefits.rightViewMode = .picker(defaultText: "暂未选择")
        
        let discountCoupon = PFFormModel()
        discountCoupon.type = ProductProcessViewModel.FormType.discountCoupon
        discountCoupon.title = "优惠券"
        discountCoupon.rightViewMode = .picker(defaultText: "暂未选择")
        
        let serviceTime = PFFormModel()
        serviceTime.isNecessary = true
        serviceTime.type = ProductProcessViewModel.FormType.serviceTime
        serviceTime.title = "预计服务时间(小时)"
        serviceTime.rightViewMode = .picker(defaultText: "暂未选择")
        serviceTime.showSeparatorLine = false
        
        info.formModels = [productName, productPrice, memberBenefits, discountCoupon, serviceTime]
        
        let image = PFFormSectionModel()
        image.title = "商品图片"
        
        let productImage = PFFormModel()
        productImage.type = ProductProcessViewModel.FormType.productName
        productImage.showSeparatorLine = false
        productImage.rightViewMode = .custom(UIView())
        productImage.rowHeight = 90
        
        let suitablePets = PFFormModel()
        suitablePets.type = ProductProcessViewModel.FormType.suitablePets
        suitablePets.title = "适用宠物"
        suitablePets.isNecessary = true
        suitablePets.rightViewMode = .options(["猫咪", "狗狗", "其他"])
        
        let productDetail = PFFormModel()
        productDetail.type = ProductProcessViewModel.FormType.productDetail
        productDetail.title = "商品详情"
        productDetail.isNecessary = true
        productDetail.rightViewMode = .textView(placeholder: nil, defaultText: nil)
        productDetail.showSeparatorLine = false
        productDetail.rowHeight = 160
        
        image.formModels = [productImage, suitablePets, productDetail]
        
        return [info, image]
    }
    
    func buildUI() {
        formView = PFFormView(frame: .zero, sectionModels: formSectionModels)
    }
}
