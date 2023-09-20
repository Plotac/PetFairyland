//
//  LoginViewController.swift
//  PFAccount
//
//  Created by Ja on 2023/7/26.
//

import Foundation
import SnapKit
import PFUtility

class LoginViewController: PFBaseViewController {
    
    private(set) var viewModel: LoginViewModel = LoginViewModel()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        viewModel.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}

extension LoginViewController {
    @objc func close() {
        dismiss(animated: true)
        resetNavigationBarAppearance()
    }
    
    @objc func help() {}
    
    @objc func hideKeyboard() {
        if viewModel.phoneTF.isFirstResponder {
            viewModel.phoneTF.resignFirstResponder()
        }
        if viewModel.passwordTF.isFirstResponder {
            viewModel.passwordTF.resignFirstResponder()
        }
    }
}


extension LoginViewController: LoginViewModelDelegate {
    func handleOtherLogin(channel: LoginChannel) {
        print(channel.title)
    }
    
    func handleLoginEvent(type: LoginType) {
        if type == .password {
            if viewModel.phoneTF.text == "18201884830", viewModel.passwordTF.text == "123456" {
                let userInfo = UserInfo()
                userInfo.mobileNumber = viewModel.phoneTF.text!
                
                PFAccount.shared.userInfo = userInfo
                dismiss(animated: true)
            }
        } else {
            if let phoneNumber = viewModel.phoneTF.text {
                let verifyVC = SMSVerifyViewController(phoneNumber: phoneNumber)
                navigationController?.pushViewController(verifyVC, animated: true)
            }
        }
    }
}

extension LoginViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if let touchView = touch.view, touchView.isDescendant(of: viewModel.loginChannelCV) {
            return false
        }
        return true
    }
}

extension LoginViewController {
    
    func setupUI() {
        setupNav()
        
        view.addSubview(viewModel.welcomeLab)
        viewModel.welcomeLab.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(50)
        }
        
        view.addSubview(viewModel.phoneTF)
        viewModel.phoneTF.snp.makeConstraints { make in
            make.top.equalTo(viewModel.welcomeLab.snp.bottom).offset(40)
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(40)
        }
        
        view.addSubview(viewModel.phoneLine)
        viewModel.phoneLine.snp.makeConstraints { make in
            make.top.equalTo(viewModel.phoneTF.snp.bottom)
            make.left.right.equalTo(viewModel.phoneTF)
            make.height.equalTo(1)
        }
        
        view.addSubview(viewModel.passwordTF)
        viewModel.passwordTF.snp.makeConstraints { make in
            make.top.equalTo(viewModel.phoneLine.snp.bottom).offset(30)
            make.left.right.height.equalTo(viewModel.phoneTF)
        }
        
        view.addSubview(viewModel.passwordLine)
        viewModel.passwordLine.snp.makeConstraints { make in
            make.top.equalTo(viewModel.passwordTF.snp.bottom)
            make.left.right.equalTo(viewModel.passwordTF)
            make.height.equalTo(1)
        }
        
        view.addSubview(viewModel.smsTipLab)
        viewModel.smsTipLab.snp.makeConstraints { make in
            make.top.equalTo(viewModel.phoneLine.snp.bottom).offset(5)
            make.left.equalTo(viewModel.phoneTF)
        }
        
        view.addSubview(viewModel.loginBtn)
        viewModel.loginBtn.snp.makeConstraints { make in
            make.top.equalTo(viewModel.smsTipLab.snp.bottom).offset(20)
            make.left.right.equalTo(viewModel.phoneLine)
            make.height.equalTo(50)
        }
        
        view.addSubview(viewModel.loginTypeBtn)
        viewModel.loginTypeBtn.snp.makeConstraints { make in
            make.top.equalTo(viewModel.loginBtn.snp.bottom).offset(15)
            make.left.equalTo(viewModel.phoneLine)
        }
        
        view.addSubview(viewModel.questionBtn)
        viewModel.questionBtn.snp.makeConstraints { make in
            make.top.equalTo(viewModel.loginBtn.snp.bottom).offset(15)
            make.right.equalTo(viewModel.phoneLine)
        }
        
        view.addSubview(viewModel.checkBtn)
        viewModel.checkBtn.snp.makeConstraints { make in
            make.top.equalTo(viewModel.loginTypeBtn.snp.bottom).offset(25)
            make.left.equalTo(viewModel.loginTypeBtn)
            make.size.equalTo(17)
        }
        
        view.addSubview(viewModel.textView)
        viewModel.textView.snp.makeConstraints { make in
            make.centerY.equalTo(viewModel.checkBtn)
            make.left.equalTo(viewModel.checkBtn.snp.right).offset(5)
            make.right.equalTo(viewModel.phoneTF)
        }
        
        view.addSubview(viewModel.loginChannelCV)
        viewModel.loginChannelCV.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-(kBottomSafeMargin + 40))
            make.left.right.equalTo(viewModel.phoneLine)
            make.height.equalTo(60)
        }
        
        view.addSubview(viewModel.otherLoginLab)
        viewModel.otherLoginLab.snp.makeConstraints { make in
            make.bottom.equalTo(viewModel.loginChannelCV.snp.top).offset(-15)
            make.centerX.equalToSuperview()
        }
    }
    
    func setupNav() {
        
        let closeBtn = UIButton(type: .custom)
        closeBtn.setImage(UIImage(named: "nav_close"), for: .normal)
        closeBtn.addTarget(self, action: #selector(close), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: closeBtn)
                                         
//        let helpBtn = UIButton(type: .custom)
//        helpBtn.titleLabel?.font = UIFont.systemFont(ofSize: 19)
//        helpBtn.setTitle("帮助", for: .normal)
//        helpBtn.setTitleColor(.black, for: .normal)
//        helpBtn.addTarget(self, action: #selector(help), for: .touchUpInside)
//        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: helpBtn)
    }
}
