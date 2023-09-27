//
//  AppointmentListController.swift
//  PetFairyland
//
//  Created by Ja on 2023/7/27.
//

import UIKit

class AppointmentListController: PFBaseViewController {
    
    var viewModel: AppointmentListViewModel = AppointmentListViewModel()
    
    var filterOptions: [PFFilterOption] = []
    
    var footerRefreshCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        
        setupUI()
        
        viewModel.appointmentCV.mj_header = refreshHeader
        refreshHeaderEvent = { [weak self] in
            guard let self = self else { return }
            
            self.refreshHeader.endRefreshing()
            
            self.viewModel.listModels.removeAll()
            self.viewModel.listModels = self.viewModel.generateTestModels()
            self.viewModel.appointmentCV.reloadData()
        }
        
        viewModel.appointmentCV.mj_footer = refreshFooter
        refreshFooterEvent = { [weak self] in
            guard let self = self else { return }
            
            if self.footerRefreshCount >= 2 {
                self.refreshFooter.endRefreshingWithNoMoreData()
            } else {
                self.refreshFooter.endRefreshing()
            }
            
            self.viewModel.listModels.append(contentsOf: self.viewModel.generateTestModels())
            self.viewModel.sort()
            self.viewModel.appointmentCV.reloadData()
            
            self.footerRefreshCount += 1
        }
    }
    
}

extension AppointmentListController: AppointmentListViewModelDelegate {
    func didSelectDatePickView(at index: Int) {
        refreshHeaderEvent?()
    }
}

extension AppointmentListController: PFFilterBarDelegate {
    func filterBar(_ filterBar: PFFilterBar, didSelected filter: PFFilter, selectedOption option: PFFilterOption) {
        print("PFFilterBar Selected: \(filter) ---- option: \(option.title)")
        
        var resetFlag: Bool = false
        if filterOptions.contains(where: { $0.title == option.title }) == false {
            if option.isResetAttribute == false {
                filterOptions.append(option)
            } else {
                resetFlag = true
                filterOptions.removeAll { $0.type.isEqualTo(option.type) }
            }
        }
        
        viewModel.filter(options: filterOptions, resetFlag: resetFlag)
    }
}

extension AppointmentListController {
    func setupUI() {
        title = "预约列表"
        
        view.addSubview(viewModel.datePicker)
        viewModel.datePicker.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(60)
        }
        
        viewModel.filterBar.delegate = self
        view.addSubview(viewModel.filterBar)
        viewModel.filterBar.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(viewModel.datePicker.snp.bottom)
            make.height.equalTo(40)
        }
        
        view.addSubview(viewModel.appointmentCV)
        viewModel.appointmentCV.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(viewModel.filterBar.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-kBottomSafeMargin)
        }
    }
}
