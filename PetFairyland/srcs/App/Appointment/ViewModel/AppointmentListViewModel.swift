//
//  AppointmentListViewModel.swift
//  PetFairyland
//
//  Created by Ja on 2023/7/27.
//

import UIKit
import PFUIKit

class AppointmentListViewModel: NSObject {
    
    var datePicker: PFDatePickerView!
    
    var appointmentCV: UICollectionView!
    
    override init() {
        super.init()
        buildUI()
    }
}

extension AppointmentListViewModel: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppointmentListCell.reuseIdentity(), for: indexPath)
        
        return cell
    }
}

extension AppointmentListViewModel {
    
    func buildUI() {
        
        datePicker = PFDatePickerView(frame: .zero, limiteDays: 14)

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
}
