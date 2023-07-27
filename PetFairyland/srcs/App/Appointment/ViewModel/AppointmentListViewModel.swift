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
    
    override init() {
        super.init()
        buildUI()
    }
}

extension AppointmentListViewModel {
    
    func buildUI() {
        datePicker = PFDatePickerView(frame: .zero, limiteDays: 21)

    }
}
