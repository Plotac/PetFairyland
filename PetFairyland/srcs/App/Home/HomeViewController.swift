//
//  HomeViewController.swift
//  PetFairyland
//
//  Created by Ja on 2023/7/25.
//

import UIKit
import PFAccount

class HomeViewController: PFBaseViewController {
    
    private(set) var viewModel: HomeViewModel = HomeViewModel()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "乐乐派宠物服务预约平台"
        setupUI()
        
        if PFAccount.shared.userInfo.isValid == false {
            PFAccount.login(with: SMSRequest(mobileNumber: "")) {
                
            }
        }
        
    }
    override func updateViewConstraints() {
        super.updateViewConstraints()
        updateConstraints()
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func didSelectHomeFunction(item: HomeFunctionItem) {
        switch item.type {
        case .appointment:
            navigationController?.pushViewController(AppointmentListController(), animated: true)
        case .storeManagement:
            navigationController?.pushViewController(StoreManagementController(), animated: true)
        default:
            break
        }
    }
}

private extension HomeViewController {
    @objc
    func changeSwitchValue(sw: UISwitch) {
        PFAccount.shared.isLogin = sw.isOn
        view.setNeedsUpdateConstraints()
    }
}

private extension HomeViewController {

    func updateConstraints() {
        
        viewModel.loginBtn.isHidden = PFAccount.shared.isLogin
        viewModel.dataView.isHidden = !PFAccount.shared.isLogin

        viewModel.dataView.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(80)
        }
        
        viewModel.mainTableView.snp.remakeConstraints { make in
            if PFAccount.shared.isLogin {
                make.top.equalTo(viewModel.dataView.snp.bottom).offset(10)
            } else {
                make.top.equalTo(viewModel.loginBtn.snp.bottom).offset(10)
            }
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(TabBar.height)
        }
    }
    
    func setupUI() {
        view.addSubview(viewModel.loginBtn)
        viewModel.loginBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.right.equalToSuperview().inset(35)
            make.height.equalTo(50)
        }
        
        view.addSubview(viewModel.dataView)
        
        view.addSubview(viewModel.mainTableView)
        updateConstraints()
        
        let loginSwitch = UISwitch(frame: .zero)
        loginSwitch.sizeToFit()
        loginSwitch.isOn = false
        loginSwitch.addTarget(self, action: #selector(changeSwitchValue), for: .valueChanged)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: loginSwitch)
    }
}
