//
//  ProductProcessViewModel.swift
//  PetFairyland
//
//  Created by Ja on 2023/10/10.
//

import Foundation

protocol ProductProcessViewModelDelegate: NSObjectProtocol {
    func handleSelectEvent(type: ProductProcessViewModel.FormType)
}

class ProductProcessViewModel: NSObject {
    
    weak var delegate: ProductProcessViewModelDelegate?
        
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
    var couponModels: [DiscountCouponModel] = []
    
    var formView: PFFormView!
    
    var selectedFormModel: PFFormModel?
    
    var pickerTitles: [String] = []
    
    override init() {
        super.init()
        formSectionModels = generateFormSectionModels()
        couponModels = generateCouponModels()
        buildUI()
    }
    
}

extension ProductProcessViewModel: PFFormViewDelegate {
    func formView(_ formView: PFFormView, didSelectAt indexPath: IndexPath, formModel: PFFormModel) {
        delegate?.handleSelectEvent(type: .memberBenefits)
        
        selectedFormModel = formModel
        
        if formModel.rightViewMode == .picker(defaultText: nil) {
            
            var title = ""
            pickerTitles.removeAll()
            
            if formModel.type.typeDescription == FormType.memberBenefits.typeDescription {
                title = "选择会员优惠"
                pickerTitles = ["统一会员价", "统一折扣"]
            } else if formModel.type.typeDescription == FormType.discountCoupon.typeDescription {
                title = "选择优惠券"
                pickerTitles = couponModels.map({ $0.title })
            } else if formModel.type.typeDescription == FormType.serviceTime.typeDescription {
                title = "选择服务时间"
                pickerTitles = ["0.5", "1.0", "1.5", "2.0","2.5", "3.0", "3.5", "4.0"]
            }
            
            let view = PFPickerView(title: title, selectionStyle: .single) {
                
            } conformHandler: { selectedIndexPaths in
                selectedIndexPaths.forEach { indexPath in
                    print("选中了------- \(self.pickerTitles[indexPath.row])")
                }
            }
            if formModel.type.typeDescription == FormType.discountCoupon.typeDescription {
                view.register(ProductDiscountCouponCell.self, forCellReuseIdentifier: ProductDiscountCouponCell.reuseIdentity())
            }
            
            view.delegate = self
            view.show(animated: true)
        }
    }
}

extension ProductProcessViewModel: PFPickerViewDelegate {
    func numberOfRows(inSection section: Int) -> Int { pickerTitles.count }
    
    func pickerView(_ pickerView: PFPickerView, cell: PFPickerCell, at indexPath: IndexPath) {
        if selectedFormModel?.type.typeDescription == FormType.memberBenefits.typeDescription {
            cell.titleLab.text = pickerTitles[indexPath.row]
            cell.titleLab.textColor = cell.selectBtn.isSelected ? UIColor(hexString: "#000000") : UIColor(hexString: "#999999")
            cell.titleLab.font = .pingfang(style: cell.selectBtn.isSelected ? .semibold : .regular, size: 14)
        } else if selectedFormModel?.type.typeDescription == FormType.discountCoupon.typeDescription, let couponCell = cell as? ProductDiscountCouponCell {
            couponCell.model = couponModels[indexPath.row]
        }
    }
    
    func pickerView(_ pickerView: PFPickerView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedFormModel?.type.typeDescription == FormType.discountCoupon.typeDescription {
            return 115
        }
        return 50
    }
}

extension ProductProcessViewModel {
    func generateFormSectionModels() -> [PFFormSectionModel] {
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
    
    func generateCouponModels() -> [DiscountCouponModel] {
        let coupon1 = DiscountCouponModel()
        coupon1.discount = 30
        coupon1.type = .moneyOff
        coupon1.status = .enable
        coupon1.targetAmount = 100
        coupon1.validityType = .forever
        coupon1.sharedWithMemberPrice = true
        
        let coupon2 = DiscountCouponModel()
        coupon2.discount = 50
        coupon2.type = .moneyOff
        coupon2.status = .enable
        coupon2.targetAmount = 300
        coupon2.validityType = .beforeExpirationDate(1703952000)
        
        let coupon3 = DiscountCouponModel()
        coupon3.discount = 8.5
        coupon3.type = .discount
        coupon3.status = .enable
        coupon3.targetAmount = 200
        coupon3.validityType = .limitDays(30)
        
        let coupon4 = DiscountCouponModel()
        coupon4.discount = 20
        coupon4.type = .moneyOff
        coupon4.status = .disabled
        coupon4.targetAmount = 100
        coupon4.validityType = .timePeriod(1693497600, 1696003200)
        coupon1.sharedWithMemberPrice = true
        
        let coupon5 = DiscountCouponModel()
        coupon5.discount = 9.5
        coupon5.type = .discount
        coupon5.status = .disabled
        coupon5.targetAmount = 100
        coupon5.validityType = .timePeriod(1696089600, 1698681600)
        
        return [coupon1, coupon2, coupon3, coupon4, coupon5]
    }
    
    func buildUI() {
        formView = PFFormView(frame: .zero, sectionModels: formSectionModels)
        formView.delegate = self
    }
}
