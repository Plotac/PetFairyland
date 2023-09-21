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
    
    var textFields: [SMSTextfield] = []
    var indicators: [UIView] = []
    var refreshCodeBtn: UIButton!
    
    let indicatorColor: (normal: UIColor, select: UIColor) = (UIColor(hexString: "F2F2F2"), UIColor(hexString: "#808080"))
    
    var timer: PFTimer?
    
    var countDown: Int = 5
    
    required init(phoneNumber: String) {
        super.init(nibName: nil, bundle: nil)
        self.phoneNumber = phoneNumber
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        startTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textFields[0].becomeFirstResponder()
        indicators[0].backgroundColor = indicatorColor.select
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        setRefreshCodeBtn(isCountDown: false)
        
        textFields.forEach { $0.text = "" }
        indicators.forEach { $0.backgroundColor = indicatorColor.normal }
        
        view.endEditing(true)
    }
    
    deinit {
        print("SMSVerifyViewController - deinit")
    }
}

extension SMSVerifyViewController {
    @objc
    func startTimer() {
        if timer == nil {
            timer = PFTimer(timeInterval: 1, repeats: true, style: .gcd, eventHandler: {
                self.countDown -= 1
                self.setRefreshCodeBtn(isCountDown: self.countDown >= 0)
            })
            timer?.fire()
        }
    }
    
    func finishInput(code: String) {
        let vc = IdentitySelectionController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SMSVerifyViewController: UITextFieldDelegate, SMSTextfieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var index = textField.tag
        
        if !textField.hasText {
        
            textFields[index].text = string
            
            if index == textFields.count - 1 {
                var code = ""
                for tf in textFields {
                    code += tf.text ?? ""
                }
                finishInput(code: code)
                
                return false
            }
            
            textFields[index + 1].becomeFirstResponder()
            
            indicators[index].backgroundColor = indicatorColor.normal
            indicators[index + 1].backgroundColor = indicatorColor.select
        }
        
        
        return false
    }
    
    func textFieldDidDeleteBackward(_ textField: SMSTextfield) {
        var index = textField.tag
        
        if textField.hasText == false {
            indicators[index].backgroundColor = indicatorColor.normal
            
            index = max(index - 1, 0)
            textFields[index].text = ""
            textFields[index].becomeFirstResponder()
            
            indicators[index].backgroundColor = indicatorColor.select
        }
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
            let tf = SMSTextfield()
            tf.tintColor = SystemColor.main
            tf.textAlignment = .center
            tf.delegate = self
            tf.smsDelegate = self
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
            
            textFields.append(tf)
            
            let indicator = UIView()
            indicator.clipsToBounds = true
            indicator.layer.cornerRadius = 0.5
            indicator.backgroundColor = indicatorColor.normal
            view.addSubview(indicator)
            indicator.snp.makeConstraints { make in
                make.left.right.equalTo(tf)
                make.top.equalTo(tf.snp.bottom)
                make.height.equalTo(1)
            }
            
            indicators.append(indicator)
            
            if index == 0 {
                tf.becomeFirstResponder()
                indicator.backgroundColor = indicatorColor.select
            }
        }
        
        refreshCodeBtn = UIButton(type: .custom)
        refreshCodeBtn.setTitle("重新获取验证码", for: .normal)
        refreshCodeBtn.layer.cornerRadius = 25
        refreshCodeBtn.backgroundColor = SystemColor.Button.enable
        refreshCodeBtn.layer.masksToBounds = true
        refreshCodeBtn.titleLabel?.font = UIFont.pingfang(style: .medium, size: 17)
        refreshCodeBtn.setTitleColor(UIColor(hexString: "#B28457"), for: .normal)
        refreshCodeBtn.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        view.addSubview(refreshCodeBtn)
        refreshCodeBtn.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(34)
            make.top.equalTo(textFields.first!.snp.bottom).offset(40)
            make.height.equalTo(50)
        }
    }
    
    func setRefreshCodeBtn(isCountDown: Bool) {
        if isCountDown == false {
            refreshCodeBtn.setTitle("重新获取验证码", for: .normal)
            refreshCodeBtn.setTitleColor(.black, for: .normal)
            refreshCodeBtn.backgroundColor = SystemColor.Button.enable
            refreshCodeBtn.isEnabled = true
            countDown = 5
            
            timer?.invalidate()
            timer = nil
        } else {
            refreshCodeBtn.setTitle("\(countDown)秒后重新获取", for: .normal)
            refreshCodeBtn.setTitleColor(UIColor(hexString: "#B28457"), for: .normal)
            refreshCodeBtn.backgroundColor = SystemColor.Button.disable
            refreshCodeBtn.isEnabled = false
        }
    }
}

protocol SMSTextfieldDelegate: NSObjectProtocol {
    func textFieldDidDeleteBackward(_ textField: SMSTextfield)
}

class SMSTextfield: UITextField {
    
    weak var smsDelegate: SMSTextfieldDelegate?
    
    override func deleteBackward() {
        smsDelegate?.textFieldDidDeleteBackward(self)
        super.deleteBackward()
    }
}
