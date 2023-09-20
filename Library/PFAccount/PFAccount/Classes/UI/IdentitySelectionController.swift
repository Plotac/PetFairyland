//
//  IdentitySelectionController.swift
//  PFAccount
//
//  Created by Ja on 2023/9/20.
//

import Foundation
import PFUtility

class IdentitySelectionController: PFBaseViewController {
    
    private(set) var viewModel: IdentitySelectionViewModel!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        viewModel = IdentitySelectionViewModel(type: .originator)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension IdentitySelectionController {
    func setupUI() {
        title = "注册成功"
        
        view.addSubview(viewModel.titleLab)
        viewModel.titleLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(35)
            make.top.equalToSuperview().offset(20)
        }
        
        view.addSubview(viewModel.chooseIdentityLab)
        viewModel.chooseIdentityLab.snp.makeConstraints { make in
            make.left.equalTo(viewModel.titleLab)
            make.top.equalTo(viewModel.titleLab.snp.bottom).offset(30)
        }
        
        var buttonX: CGFloat = 0
        for (index, (button, size)) in viewModel.identityBtns.enumerated() {
            let buttonSpace: CGFloat = 20
            
            view.addSubview(button)
            button.snp.makeConstraints { make in
                make.left.equalTo(viewModel.titleLab).offset(buttonX - 5)
                make.top.equalTo(viewModel.chooseIdentityLab.snp.bottom).offset(15)
                make.size.equalTo(size)
            }
            
            buttonX += (buttonSpace + size.width)
        }
        
        view.addSubview(viewModel.componentLab)
        view.addSubview(viewModel.storeNameTF)
        view.addSubview(viewModel.storeNameLine)
        
        view.addSubview(viewModel.componentLab)
        view.addSubview(viewModel.storeListTableView)
        
        viewModel.updateSubviewConstraints()
        
        view.addSubview(viewModel.passwordLab)
        viewModel.passwordLab.snp.makeConstraints { make in
            make.left.equalTo(viewModel.titleLab)
            var view: UIView = viewModel.identityBtns[0].0
            if viewModel.type == .originator {
                view = viewModel.storeNameLine
            } else if viewModel.type == .assistant {
                view = viewModel.storeListTableView
            }
            make.top.equalTo(view.snp.bottom).offset(15)
        }
        
        view.addSubview(viewModel.passwordTF)
        viewModel.passwordTF.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(35)
            make.top.equalTo(viewModel.passwordLab.snp.bottom).offset(10)
            make.height.equalTo(20)
        }
        
        view.addSubview(viewModel.passwordLine)
        viewModel.passwordLine.snp.makeConstraints { make in
            make.left.right.equalTo(viewModel.passwordTF)
            make.top.equalTo(viewModel.passwordTF.snp.bottom).offset(10)
            make.height.equalTo(0.5)
        }
        
        view.addSubview(viewModel.confirmPwLab)
        viewModel.confirmPwLab.snp.makeConstraints { make in
            make.left.equalTo(viewModel.passwordTF)
            make.top.equalTo(viewModel.passwordLine.snp.bottom).offset(5)
        }
        
        view.addSubview(viewModel.confirmPwTF)
        viewModel.confirmPwTF.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(35)
            make.top.equalTo(viewModel.confirmPwLab.snp.bottom).offset(10)
            make.height.equalTo(viewModel.passwordTF)
        }
        
        view.addSubview(viewModel.confirmPwLine)
        viewModel.confirmPwLine.snp.makeConstraints { make in
            make.left.right.equalTo(viewModel.confirmPwTF)
            make.top.equalTo(viewModel.confirmPwTF.snp.bottom).offset(10)
            make.height.equalTo(0.5)
        }
        
        view.addSubview(viewModel.confirmBtn)
        viewModel.confirmBtn.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(35)
            make.bottom.equalToSuperview().offset(-(kBottomSafeMargin + 15))
            make.height.equalTo(50)
        }
    }
}
