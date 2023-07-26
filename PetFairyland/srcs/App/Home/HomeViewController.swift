//
//  HomeViewController.swift
//  PetFairyland
//
//  Created by Ja on 2023/7/25.
//

import UIKit
import PFAccount
import PFUtility

class HomeViewController: UIViewController {
    
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
        title = "Home"
        setupUI()
        PFAccount.login(with: SMSRequest(mobileNumber: "")) {
            
        }
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func didSelectHomeItem(item: HomeItem) {
        if PFAccount.shared.userInfo.isValid == false {
            PFAccount.login(with: SMSRequest(mobileNumber: "")) {
                
            }
        }
    }
}

private extension HomeViewController {
    
}

private extension HomeViewController {
    func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(viewModel.mainCollectinView)
        viewModel.mainCollectinView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(kBottomSafeMargin)
        }
    }
}
