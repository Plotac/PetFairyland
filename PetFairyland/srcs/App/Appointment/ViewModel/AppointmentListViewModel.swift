//
//  AppointmentListViewModel.swift
//  PetFairyland
//
//  Created by Ja on 2023/7/27.
//

import UIKit
import PFUIKit

protocol AppointmentListViewModelDelegate: NSObjectProtocol {
    func didSelectDatePickView(at index: Int)
}

class AppointmentListViewModel: NSObject {
    
    weak var delegate: AppointmentListViewModelDelegate?
    
    var datePicker: PFDatePickerView!
    
    var serverFilter: PFFilter!
    var orderFilter: PFFilter!
    var serviceFilter: PFFilter!
    
    var filterBar: PFFilterBar!
    
    var appointmentCV: UICollectionView!
    
    var listModels: [AppointmentListModel] = []
    
    let productNames = ["猫咪洗护套餐", "猫咪洁牙套餐", "猫咪洗澡", "狗狗洗护套餐", "猫三联疫苗套装", "猫咪体检套餐", "犬猫抗体检测"]
    
    override init() {
        super.init()
        buildUI()
        listModels = generateTestModels()
    }
}

extension AppointmentListViewModel: PFDatePickerViewDelegate {
    func datePickerView(_ datePickerView: PFUIKit.PFDatePickerView, didSelectedItemAt index: Int) {
        delegate?.didSelectDatePickView(at: index)
    }
}

extension AppointmentListViewModel: AppointmentListCellDelegate {
    func call(model: AppointmentListModel) {
    
    }
    
    func complete(model: AppointmentListModel) {
        
    }
    
    func canceled(model: AppointmentListModel) {
        
    }
}

extension AppointmentListViewModel: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { listModels.count }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppointmentListCell.reuseIdentity(), for: indexPath) as? AppointmentListCell ?? AppointmentListCell()
        cell.delegate = self
        cell.model = listModels[indexPath.item]
        return cell
    }
}

extension AppointmentListViewModel {
    
    func buildUI() {
        
        datePicker = PFDatePickerView(frame: .zero, limiteDays: 14)
        datePicker.delegate = self
        
        let serverOptions = [
            PFFilterOption(title: "全部老师", selected: true),
            PFFilterOption(title: "Coco", selected: false),
            PFFilterOption(title: "Tom", selected: false),
            PFFilterOption(title: "Jerry", selected: false),
        ]
        serverFilter = PFFilter(frame: .zero, options: serverOptions)
        
        let orderOptions = [
            PFFilterOption(title: "全部状态", selected: true),
            PFFilterOption(title: "已完成", selected: true),
            PFFilterOption(title: "未完成", selected: false),
            PFFilterOption(title: "已取消", selected: false),
        ]
        orderFilter = PFFilter(frame: .zero, options: orderOptions)
        
        var serviceOption: [PFFilterOption] = []
        productNames.forEach { name in
            let option = PFFilterOption(title: name, selected: false)
            serviceOption.append(option)
        }
        serviceOption.insert(PFFilterOption(title: "服务筛选", selected: true), at: 0)
        serviceFilter = PFFilter(frame: .zero, options: serviceOption)
        
        filterBar = PFFilterBar(frame: .zero, filters: [serverFilter, orderFilter, serviceFilter])

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: Screen.width - 14 * 2, height: 200)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        
        appointmentCV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        appointmentCV.delegate = self
        appointmentCV.dataSource = self
        appointmentCV.backgroundColor = .clear
        appointmentCV.register(AppointmentListCell.self, forCellWithReuseIdentifier: AppointmentListCell.reuseIdentity())
    }
    
    func generateTestModels() -> [AppointmentListModel] {
        let servers = ["Coco", "Tony", "Tom", "Jerry"]
        var models: [AppointmentListModel] = []
        for _ in 0..<20 {
            let model = AppointmentListModel()
            model.productName = productNames[Int(arc4random() % UInt32(productNames.count))]
            model.pet = "小五"
            model.master = "隔壁老王"
            model.appointmentServer = servers[Int(arc4random() % UInt32(servers.count))]
            model.appointmentTime = Int64(Date().timeIntervalSince1970)
            model.remark = "怂的一批"
            model.status = AppointmentListModel.Status.init(rawValue: Int(arc4random() % 3)) ?? .unfinished
            model.type = AppointmentListModel.OrderType.init(rawValue: Int(arc4random() % 2)) ?? .old
            model.identityType = AppointmentListModel.IdentityType.init(rawValue: Int(arc4random() % 3)) ?? .customer
            models.append(model)
            models.sort { $0.type.rawValue < $1.type.rawValue }
        }
        return models
    }
    
    func sort() {
        listModels.sort { $0.type.rawValue < $1.type.rawValue }
    }
}
