//
//  AppointmentListController.swift
//  PetFairyland
//
//  Created by Ja on 2023/7/27.
//

import UIKit

class AppointmentListController: PFBaseViewController {
    
    var viewModel: AppointmentListViewModel = AppointmentListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "预约列表"
        
        view.addSubview(viewModel.datePicker)
        viewModel.datePicker.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(60)
        }
    }
}
