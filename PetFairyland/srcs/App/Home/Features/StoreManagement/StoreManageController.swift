//
//  StoreManageController.swift
//  PetFairyland
//
//  Created by Ja on 2023/8/1.
//

import Foundation
import PFUIKit

class StoreManageController: PFBaseViewController {
    
    enum FormType: PFFormType {
        case storeName
        case linkman
        case linkmanPhoneNumber
        case storePhoneNumer
        case storeIntroduction
        case storeLocation
        
        var typeDescription: String {
            let prefix: String = "StoreManageController.FormType."
            switch self {
            case .storeName:
                return prefix + "storeName"
            case .linkman:
                return prefix + "linkman"
            case .linkmanPhoneNumber:
                return prefix + "linkmanPhoneNumber"
            case .storePhoneNumer:
                return prefix + "storePhoneNumer"
            case .storeIntroduction:
                return prefix + "storeIntroduction"
            case .storeLocation:
                return prefix + "storeLocation"
            }
        }
    }
    
    var formView: PFFormView!
    var formModels: [PFFormModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "门店管理"
        generateformModels()
        setupUI()
    }
}

extension StoreManageController {
    
    func generateformModels() {
        let storeName = PFFormModel()
        storeName.isNecessary = true
        storeName.title = "店铺名称"
        storeName.type = StoreManageController.FormType.storeName
        storeName.rightViewMode = .textfield(placeholder: "请输入店铺名称", defaultText: nil)
        
        let linkman = PFFormModel()
        linkman.isNecessary = true
        linkman.title = "联系人"
        linkman.type = StoreManageController.FormType.linkman
        linkman.rightViewMode = .textfield(placeholder: "请输入联系人名称", defaultText: nil)
        
        let linkmanPhoneNumber = PFFormModel()
        linkmanPhoneNumber.isNecessary = true
        linkmanPhoneNumber.title = "联系人电话"
        linkmanPhoneNumber.type = StoreManageController.FormType.linkmanPhoneNumber
        linkmanPhoneNumber.rightViewMode = .textfield(placeholder: "请输入联系人电话", defaultText: nil)
        
        let storePhoneNumer = PFFormModel()
        storePhoneNumer.title = "门店电话"
        storePhoneNumer.type = StoreManageController.FormType.storePhoneNumer
        storePhoneNumer.rightViewMode = .textfield(placeholder: "请输入门店电话", defaultText: nil)
        
        let storeIntroduction = PFFormModel()
        storeIntroduction.rowHeight = 100
        storeIntroduction.title = "门店介绍"
        storeIntroduction.type = StoreManageController.FormType.storeIntroduction
        linkmanPhoneNumber.rightViewMode = .textView(placeholder: "请输入门店介绍", defaultText: nil)
        
        let storeLocation = PFFormModel()
        storeLocation.rowHeight = 80
        storeLocation.title = "门店位置"
        storeLocation.type = StoreManageController.FormType.storeLocation
        linkmanPhoneNumber.rightViewMode = .textView(placeholder: "请输入门店位置", defaultText: nil)
        
        formModels = [storeName, linkman, linkmanPhoneNumber, storePhoneNumer, storeIntroduction, storeLocation]
    }
    
    func setupUI() {
//        formView = PFFormView(frame: .zero, models: formModels)
//        view.addSubview(formView)
//        formView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
    }
}
