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
        storeName.placeholder = "请输入店铺名称"
        storeName.type = StoreManageController.FormType.storeName
        
        let linkman = PFFormModel()
        linkman.isNecessary = true
        linkman.title = "联系人"
        linkman.placeholder = "请输入联系人名称"
        linkman.type = StoreManageController.FormType.linkman
        
        let linkmanPhoneNumber = PFFormModel()
        linkmanPhoneNumber.isNecessary = true
        linkmanPhoneNumber.title = "联系人电话"
        linkmanPhoneNumber.placeholder = "请输入联系人电话"
        linkmanPhoneNumber.type = StoreManageController.FormType.linkmanPhoneNumber
        
        let storePhoneNumer = PFFormModel()
        storePhoneNumer.title = "门店电话"
        storePhoneNumer.placeholder = "请输入门店电话"
        storePhoneNumer.type = StoreManageController.FormType.storePhoneNumer
        
        let storeIntroduction = PFFormModel()
        storeIntroduction.rightViewMode = .textView
        storeIntroduction.rowHeight = 100
        storeIntroduction.title = "门店介绍"
        storeIntroduction.placeholder = "请输入门店介绍"
        storeIntroduction.type = StoreManageController.FormType.storeIntroduction
        
        let storeLocation = PFFormModel()
        storeLocation.rightViewMode = .textView
        storeLocation.rowHeight = 80
        storeLocation.title = "门店位置"
        storeLocation.placeholder = "请输入门店位置"
        storeLocation.type = StoreManageController.FormType.storeLocation
        
        formModels = [storeName, linkman, linkmanPhoneNumber, storePhoneNumer, storeIntroduction, storeLocation]
    }
    
    func setupUI() {
        formView = PFFormView(frame: .zero, models: formModels)
        view.addSubview(formView)
        formView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
