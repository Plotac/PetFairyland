//
//  SMSVerifyViewController.swift
//  PFAccount
//
//  Created by Ja on 2023/9/20.
//

import Foundation
import PFUtility

class SMSVerifyViewController: PFBaseViewController {
    
    var phoneNumber: String = ""
    
    var textFields: [UITextField] = []
    var refreshCodeBtn: UIButton!
    
    var timer: PFTimer?
    
    var countDown: Int = 60
    
    required init(phoneNumber: String) {
        super.init(nibName: nil, bundle: nil)
        self.phoneNumber = phoneNumber
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        startTimer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
        timer = nil
    }
    
    func startTimer() {
        if timer == nil {
            timer = PFTimer(timeInterval: 1, repeats: true, style: .gcd, eventHandler: {
                self.countDown -= 1
                if self.countDown < 0 {
                    self.refreshCodeBtn.setTitle("重新获取验证码", for: .normal)
                    self.refreshCodeBtn.backgroundColor = SystemColor.Button.enable
                    self.refreshCodeBtn.isEnabled = true
                    self.countDown = 60
                    
                    self.timer?.invalidate()
                    self.timer = nil
                } else {
                    self.refreshCodeBtn.setTitle("\(self.countDown)秒后重新获取", for: .normal)
                    self.refreshCodeBtn.backgroundColor = SystemColor.Button.disable
                    self.refreshCodeBtn.isEnabled = false
                }
            })
            timer?.fire()
        }
    }
    
    deinit {
        print("SMSVerifyViewController - deinit")
    }
}

extension SMSVerifyViewController {
    @objc
    func refreshVerificationCode() {

    }
    
    func finishInput(code: String) {
        let vc = IdentitySelectionController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SMSVerifyViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if !textField.hasText {
            
            let index = textField.tag
            textFields[index].text = string
            textField.resignFirstResponder()
            
            if index == textFields.count - 1 {
                var code = ""
                for tf in textFields {
                    code += tf.text ?? ""
                }
                finishInput(code: code)
                return false
            }
            
            textFields[index + 1].becomeFirstResponder()
        }
        return false
    }
}

extension SMSVerifyViewController {
    func setupUI() {
        
        let titleLab = UILabel()
        titleLab.text = "输入4位验证码"
        titleLab.textColor = UIColor(hexString: "#3F3F3F")
        titleLab.font = UIFont.pingfang(style: .semibold, size: 32)
        view.addSubview(titleLab)
        titleLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(35)
            make.top.equalToSuperview().offset(20)
        }
        
        let phoneTextLab = UILabel()
        phoneTextLab.text = "验证码已发至 18436425897"
        phoneTextLab.textColor = UIColor(hexString: "#747474")
        phoneTextLab.font = UIFont.pingfang(style: .regular, size: 14)
        view.addSubview(phoneTextLab)
        phoneTextLab.snp.makeConstraints { make in
            make.left.equalTo(titleLab)
            make.top.equalTo(titleLab.snp.bottom).offset(8)
        }
        
        let textfieldCount: Int = 4
        for index in 0..<textfieldCount {
            let tf = UITextField()
            tf.tintColor = SystemColor.main
            tf.textAlignment = .center
            tf.delegate = self
            tf.font = UIFont.pingfang(style: .semibold, size: 20)
            tf.tag = index
            tf.keyboardType = .numberPad
            view.addSubview(tf)
            
            let margin: CGFloat = 33
            let space: CGFloat = 20
            let tfWidth: CGFloat = (Screen.width - margin * 2 - space * CGFloat((textfieldCount - 1))) / CGFloat(textfieldCount)
            tf.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(margin + CGFloat(index) * (tfWidth + space))
                make.top.equalTo(phoneTextLab.snp.bottom).offset(45)
                make.size.equalTo(CGSize(width: tfWidth, height: 40))
            }
            if index == 0 {
                tf.becomeFirstResponder()
            }
            
            textFields.append(tf)
        }
        
        refreshCodeBtn = UIButton(type: .custom)
        refreshCodeBtn.setTitle("重新获取验证码", for: .normal)
        refreshCodeBtn.layer.cornerRadius = 25
        refreshCodeBtn.backgroundColor = SystemColor.Button.enable
        refreshCodeBtn.layer.masksToBounds = true
        refreshCodeBtn.titleLabel?.font = UIFont.pingfang(style: .medium, size: 17)
        refreshCodeBtn.setTitleColor(UIColor(hexString: "#B28457"), for: .normal)
        refreshCodeBtn.addTarget(self, action: #selector(refreshVerificationCode), for: .touchUpInside)
        view.addSubview(refreshCodeBtn)
        refreshCodeBtn.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(34)
            make.top.equalTo(textFields.first!.snp.bottom).offset(40)
            make.height.equalTo(50)
        }
    }
}
