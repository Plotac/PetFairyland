//
//  LoginViewModel.swift
//  PFAccount
//
//  Created by Ja on 2023/7/26.
//

import Foundation
import PFUtility
import PFUIKit

protocol LoginViewModelDelegate: NSObjectProtocol {
    
}

class LoginViewModel: NSObject {
    
    var loginType: LoginType = .sms
    
    weak var delegate: LoginViewModelDelegate?
    
    lazy var welcomeLab: UILabel = {
        let lab = UILabel()
        lab.text = "欢迎登录"
        lab.textColor = .black
        lab.font = UIFont.systemFont(ofSize: 35)
        return lab
    }()
    
    lazy var phoneTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "请输入手机号"
        tf.font = UIFont.systemFont(ofSize: 19)
        tf.keyboardType = .numberPad
        tf.tintColor = SystemColor.main
        return tf
    }()
    
    lazy var phoneLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var passwordTF: UITextField = {
        let tf = UITextField()
        tf.isHidden = true
        tf.placeholder = "请输入密码"
        tf.font = UIFont.systemFont(ofSize: 19)
        tf.tintColor = SystemColor.main
        tf.isSecureTextEntry = true
        let secureBtn = UIButton(type: .custom)
        secureBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        secureBtn.setImage(UIImage(named: "password_hide"), for: .normal)
        secureBtn.setImage(UIImage(named: "password_show"), for: .selected)
        secureBtn.addTarget(self, action: #selector(passwordSecure(sender:)), for: .touchUpInside)
        tf.rightView = secureBtn
        tf.rightViewMode = .always
        return tf
    }()
    
    lazy var passwordLine: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var smsTipLab: UILabel = {
        let lab = UILabel()
        lab.text = "未注册手机号验证后会自动创建账号"
        lab.textColor = UIColor(hexString: "#B3B3B3")
        lab.font = UIFont.systemFont(ofSize: 15)
        return lab
    }()
    
    lazy var checkBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.imageView?.contentMode = .scaleAspectFill
        btn.setImage(UIImage(named: "checkBox_unselect"), for: .normal)
        btn.setImage(UIImage(named: "checkBox_select"), for: .selected)
        btn.addTarget(self, action: #selector(check(sender:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var textView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.showsHorizontalScrollIndicator = false
        tv.delegate = self
        tv.isEditable = false
        tv.isScrollEnabled = false
        tv.textContainerInset = .zero
        tv.font = UIFont.systemFont(ofSize: 13)
        
        let userAgreement = "《用户协议》"
        let privacyPolicy = "《隐私政策》"
        let totalText = String(format: "我已阅读并同意%@、%@，并授权本应用使用该账号信息（如昵称、头像、手机号）进行统一管理。", userAgreement, privacyPolicy)
        var attStr = NSMutableAttributedString(string: totalText)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        
        let userAgreementRange = NSRange(attStr.string.range(of: userAgreement)!, in: attStr.string)
        let privacyPolicyRange = NSRange(attStr.string.range(of: privacyPolicy)!, in: attStr.string)
        
        attStr.addAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
                              NSAttributedString.Key.foregroundColor: UIColor(hexString: "#808080"),
                              NSAttributedString.Key.paragraphStyle: paragraphStyle,
                              NSAttributedString.Key.kern: 1], range: NSRange(attStr.string.range(of: attStr.string)!, in: attStr.string))
        attStr.addAttributes([NSAttributedString.Key.link: kUserAgreementUrl,
                              NSAttributedString.Key.kern: 1], range: userAgreementRange)
        attStr.addAttributes([NSAttributedString.Key.link: kPrivacyPolicyUrl,
                              NSAttributedString.Key.kern: 1], range: privacyPolicyRange)
        
        tv.attributedText = attStr
        tv.linkTextAttributes = [.foregroundColor: SystemColor.main,
            .font: UIFont.systemFont(ofSize: 14)]
        return tv
    }()
    
    lazy var loginBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("获取短信验证码", for: .normal)
        btn.layer.cornerRadius = 7
        btn.backgroundColor = SystemColor.main.withAlphaComponent(0.3)
        btn.layer.masksToBounds = true
        btn.isEnabled = false
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.setTitleColor(.black.withAlphaComponent(0.3), for: .normal)
        btn.addTarget(self, action: #selector(login(sender:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var loginTypeBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("密码登录", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.setTitleColor(UIColor(hexString: "#808080"), for: .normal)
        btn.addTarget(self, action: #selector(changeLoginWay(sender:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var questionBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("遇到问题", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.setTitleColor(UIColor(hexString: "#808080"), for: .normal)
        btn.addTarget(self, action: #selector(question(sender:)), for: .touchUpInside)
        return btn
    }()
    
    var loginChannelCV: UICollectionView!
    
    var loginChannels: [LoginChannel] = []
    
    override init() {
        super.init()
        loadChannelData()
        buildUI()
        NotificationCenter.default.addObserver(self, selector: #selector(textfieldTextDidChange(notification:)), name: UITextField.textDidChangeNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension LoginViewModel: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { loginChannels.count }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoginChannelCell.reuseIdentity(), for: indexPath) as? LoginChannelCell ?? LoginChannelCell()
        cell.channel = loginChannels[indexPath.item]
        return cell
    }
    
}

extension LoginViewModel: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if textView == self.textView {
            let urlString = URL.absoluteString
            if !urlString.isEmpty {
                if urlString == kUserAgreementUrl {
                    jumpToWebVC(title: "用户协议", urlStr: urlString)
                    return false
                } else if urlString == kPrivacyPolicyUrl {
                    jumpToWebVC(title: "隐私政策", urlStr: urlString)
                    return false
                }
            }
        }
        return true
    }
    
    func jumpToWebVC(title: String, urlStr: String) {
        if !urlStr.isEmpty, let parentVC = delegate as? UIViewController {
            let vc = PFWebViewController(urlStr: urlStr)
            vc.title = title
            parentVC.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension LoginViewModel {
    @objc func check(sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @objc func passwordSecure(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        passwordTF.isSecureTextEntry = !sender.isSelected
    }
    
    @objc func login(sender: UIButton) {
        
    }
    
    @objc func changeLoginWay(sender: UIButton) {
        
        if loginType == .sms {
            loginType = .password
        } else if loginType == .password {
            loginType = .sms
        }
        
        smsTipLab.isHidden = loginType == .password
        passwordTF.isHidden = loginType == .sms
        passwordLine.isHidden = loginType == .sms
        loginBtn.setTitle(loginType == .sms ? "获取短信验证码" : "登录", for: .normal)
        loginTypeBtn.setTitle(loginType == .sms ? "密码登录" : "验证码登录", for: .normal)
        
        updateConstraints()
    }
    
    @objc func question(sender: UIButton) {
    }
    
    @objc func textfieldTextDidChange(notification: Notification) {
        let phoneIsEmpty: Bool = phoneTF.text?.isEmpty ?? true
        let passwordIsEmpty: Bool = passwordTF.text?.isEmpty ?? true
        if loginType == .sms {
            loginBtn.backgroundColor = phoneIsEmpty ? SystemColor.main.withAlphaComponent(0.3) : SystemColor.main
            loginBtn.isEnabled = !phoneIsEmpty
            loginBtn.setTitleColor(phoneIsEmpty ? .black.withAlphaComponent(0.3) : .black, for: .normal)
        } else {
            loginBtn.backgroundColor = (phoneIsEmpty || passwordIsEmpty) ? SystemColor.main.withAlphaComponent(0.3) : SystemColor.main
            loginBtn.isEnabled = !phoneIsEmpty || passwordIsEmpty
            loginBtn.setTitleColor(phoneIsEmpty || passwordIsEmpty ? .black.withAlphaComponent(0.3) : .black, for: .normal)
        }
    }
    
}


extension LoginViewModel {
    func buildUI() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (Screen.width - 50 * 2)/CGFloat(loginChannels.count), height: 60)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        loginChannelCV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        loginChannelCV.dataSource = self
        loginChannelCV.backgroundColor = .clear
        loginChannelCV.delegate = self
        loginChannelCV.showsVerticalScrollIndicator = false
        loginChannelCV.showsHorizontalScrollIndicator = false
        loginChannelCV.register(LoginChannelCell.self, forCellWithReuseIdentifier: LoginChannelCell.reuseIdentity())
    }
    
    func updateConstraints() {
        checkBtn.snp.remakeConstraints { make in
            make.top.equalTo(loginType == .sms ? phoneLine.snp.bottom : passwordLine.snp.bottom).offset(loginType == .sms ? 55 : 35)
            make.left.equalTo(phoneTF)
            make.size.equalTo(30)
        }
    }
    
    func loadChannelData() {
        let wx = LoginChannel(title: "微信登录", imageStr: "login_channel_wx")
        let qq = LoginChannel(title: "QQ登录", imageStr: "login_channel_qq")
        let apple = LoginChannel(title: "AppleID登录", imageStr: "login_channel_apple")
        loginChannels = [wx, qq, apple]
    }
}


fileprivate let kUserAgreementUrl = "https://page.qingnangchina.com/plantmaster/agreementiOS.html"
fileprivate let kPrivacyPolicyUrl = "https://page.qingnangchina.com/plantmaster/policyiOS.html"
