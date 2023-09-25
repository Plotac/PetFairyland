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
    
    var appointmentCV: UICollectionView!
    
    var listModels: [AppointmentListModel] = []
    
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
            model.productName = "猫咪洗护套餐"
            model.pet = "小五"
            model.master = "隔壁老王"
            model.appointmentServer = servers[Int(arc4random() % UInt32(servers.count))]
            model.appointmentTime = Int64(Date().timeIntervalSince1970)
            model.remark = "怂的一批"
            model.status = AppointmentListModel.Status.init(rawValue: Int(arc4random() % 3)) ?? .unfinished
            model.type = AppointmentListModel.OrderType.init(rawValue: Int(arc4random() % 2)) ?? .old
            models.append(model)
            models.sort { $0.type.rawValue < $1.type.rawValue }
        }
        return models
    }
    
    func sort() {
        listModels.sort { $0.type.rawValue < $1.type.rawValue }
    }
}
