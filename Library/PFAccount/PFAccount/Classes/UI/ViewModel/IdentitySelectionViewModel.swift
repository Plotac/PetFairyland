//
//  IdentitySelectionViewModel.swift
//  PFAccount
//
//  Created by Ja on 2023/9/20.
//

import Foundation
import PFUtility

class IdentitySelectionViewModel: NSObject {
    
    var type: UserInfo.IdentityType!
    
    var titleLab: UILabel!
    var chooseIdentityLab: UILabel!
    
    lazy var componentLab: UILabel = {
        return buildSubTitleLab()
    }()
    
    lazy var storeNameTF: UITextField = {
        return buildTextfield(placeholder: "输入店铺名称")
    }()
    
    lazy var storeNameLine: UIView = {
        return buildSeparatorLine()
    }()
    
    lazy var storeListTableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.backgroundColor = .clear
        tv.dataSource = self
        tv.delegate = self
        tv.showsVerticalScrollIndicator = false
        tv.showsHorizontalScrollIndicator = false
        tv.rowHeight = 30
        tv.tableFooterView = UIView()
        tv.separatorStyle = .none
        tv.register(StoreListCell.self, forCellReuseIdentifier: StoreListCell.reuseIdentity())
        return tv
    }()
    
    var passwordLab: UILabel!
    var passwordTF: UITextField!
    var passwordLine: UIView!
    
    var confirmPwLab: UILabel!
    var confirmPwTF: UITextField!
    var confirmPwLine: UIView!
    
    var confirmBtn: UIButton!
    
    var identityBtns: [(UIButton, CGSize)] = []
    
    var storeTuples: [(String, Bool)] = []
    
    required init(type: UserInfo.IdentityType) {
        super.init()
        
        self.type = type
        storeTuples = [("小佩宠物(正弘城店)", true), ("小佩宠物(绿地360店)", false)]
        
        buildUI()
    }
}

extension IdentitySelectionViewModel {
    @objc
    func changeIdentity(sender: UIButton) {
        identityBtns.map { $0.0 }.forEach { $0.isSelected = $0.tag == sender.tag }
        type = UserInfo.IdentityType(rawValue: sender.tag)
        updateSubviewConstraints()
    }
    
    @objc
    func confirmEvent() {
        
    }
}

extension IdentitySelectionViewModel: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { storeTuples.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoreListCell.reuseIdentity(), for: indexPath) as? StoreListCell ?? StoreListCell()
        cell.nameLab.text = storeTuples[indexPath.row].0
        cell.selectBtn.isSelected = storeTuples[indexPath.row].1
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectTuple = storeTuples[indexPath.row]
        selectTuple.1 = true
        
        storeTuples = storeTuples.map { ($0.0, false) }
        if let idx = storeTuples.firstIndex { $0.0 == selectTuple.0 } {
            let selectIndex = Int(idx)
            storeTuples[selectIndex] = selectTuple
            tableView.reloadData()
        }
    }
}

extension IdentitySelectionViewModel {
    func updateSubviewConstraints() {
        setComponentLabText()
        
        var view: UIView = identityBtns[0].0
        if type == .originator {
            componentLab.isHidden = false
            storeNameTF.isHidden = false
            storeNameLine.isHidden = false
            storeListTableView.isHidden = true
            componentLab.snp.remakeConstraints { make in
                make.left.equalTo(titleLab)
                make.top.equalTo(identityBtns[0].0.snp.bottom).offset(15)
            }
            storeNameTF.snp.remakeConstraints { make in
                make.left.right.equalToSuperview().inset(35)
                make.top.equalTo(componentLab.snp.bottom).offset(10)
                make.height.equalTo(20)
            }
            storeNameLine.snp.remakeConstraints { make in
                make.left.right.equalTo(storeNameTF)
                make.top.equalTo(storeNameTF.snp.bottom).offset(10)
                make.height.equalTo(0.5)
            }
            
            view = storeNameLine
        } else if type == .assistant {
            componentLab.isHidden = false
            storeNameTF.isHidden = true
            storeNameLine.isHidden = true
            storeListTableView.isHidden = false
            componentLab.snp.remakeConstraints { make in
                make.left.equalTo(titleLab)
                make.top.equalTo(identityBtns[0].0.snp.bottom).offset(15)
            }
            
            storeListTableView.snp.remakeConstraints { make in
                make.left.right.equalToSuperview().inset(35)
                make.top.equalTo(componentLab.snp.bottom).offset(10)
                make.height.equalTo(storeListTableView.rowHeight * CGFloat(storeTuples.count))
            }
            
            view = storeListTableView
        } else {
            componentLab.isHidden = true
            storeNameTF.isHidden = true
            storeNameLine.isHidden = true
            storeListTableView.isHidden = true
        }
        
        if passwordLab.constraints.count > 0 {
            passwordLab.snp.remakeConstraints { make in
                make.left.equalTo(titleLab)
                make.top.equalTo(view.snp.bottom).offset(15)
            }
        }
        
    }
    
    func buildUI() {
        
        titleLab = UILabel()
        titleLab.text = "您的账号已注册成功"
        titleLab.textColor = UIColor(hexString: "#000000")
        titleLab.font = UIFont.pingfang(style: .semibold, size: 20)

        chooseIdentityLab = UILabel()
        chooseIdentityLab.text = "请选择您的身份"
        chooseIdentityLab.textColor = UIColor(hexString: "#000000")
        chooseIdentityLab.font = UIFont.pingfang(style: .medium, size: 16)
        
        let identities: [(String, UserInfo.IdentityType)] = [("我是店铺创始人", .originator), ("我是店员", .assistant), ("访客", .visitor)]
        for (index, identity) in identities.enumerated() {
            
            let spaceBetweenTitleAndImage: CGFloat = 5
            let name = identity.0
            let tag = identity.1.rawValue
            
            let btn = UIButton(type: .custom)
            btn.tag = tag
            btn.titleLabel?.font = UIFont.pingfang(style: .regular, size: 14)
            btn.setTitle(name, for: .normal)
            btn.setTitleColor(.black, for: .normal)
            btn.setImage(UIImage(named: "btn_unselect"), for: .normal)
            btn.setImage(UIImage(named: "btn_select"), for: .selected)
            btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -(2 / spaceBetweenTitleAndImage), bottom: 0, right: 2 / spaceBetweenTitleAndImage)
            btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 2 / spaceBetweenTitleAndImage, bottom: 0, right: -(2 / spaceBetweenTitleAndImage))
            btn.addTarget(self, action: #selector(changeIdentity(sender:)), for: .touchUpInside)
            
            btn.isSelected = index == 0
            
            var btnWidth: CGFloat = 0
            btnWidth = name.strWidth(font: UIFont.pingfang(style: .regular, size: 14), size: CGSize(width: CGFLOAT_MAX, height: 20)) + spaceBetweenTitleAndImage + 20
            
            identityBtns.append((btn, CGSize(width: btnWidth, height: 20)))
        }
        
        setComponentLabText()
        buildPassword()
        
        confirmBtn = UIButton(type: .custom)
        confirmBtn.titleLabel?.font = UIFont.pingfang(style: .medium, size: 17)
        confirmBtn.backgroundColor = SystemColor.Button.enable
        confirmBtn.layer.masksToBounds = true
        confirmBtn.layer.cornerRadius = 25
        confirmBtn.setTitleColor(.black, for: .normal)
        confirmBtn.setTitle("确认", for: .normal)
        confirmBtn.addTarget(self, action: #selector(confirmEvent), for: .touchUpInside)
        
    }
    
    func setComponentLabText() {
        switch self.type {
        case .originator:
            componentLab.text = "店铺名称"
        case .assistant:
            componentLab.text = "已为您关联到以下店铺"
        default: break
        }
    }
    
    func buildPassword() {
        passwordLab = buildSubTitleLab(text: "设置登录密码")
        passwordTF = buildTextfield(placeholder: "请输入密码")
        passwordLine = buildSeparatorLine()
        
        confirmPwLab = buildSubTitleLab(text: "确认密码")
        confirmPwTF = buildTextfield(placeholder: "请确认密码")
        confirmPwLine = buildSeparatorLine()
    }
    
    func buildSubTitleLab(text: String? = nil) -> UILabel {
        let lab = UILabel()
        lab.text = text
        lab.textColor = UIColor(hexString: "#000000")
        lab.font = UIFont.pingfang(style: .medium, size: 16)
        return lab
    }
    
    func buildTextfield(placeholder: String) -> UITextField {
        let tf = UITextField()
        tf.placeholder = placeholder
        tf.font = UIFont.pingfang(style: .medium, size: 14)
        tf.tintColor = SystemColor.main
        return tf
    }
    
    func buildSeparatorLine() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#EDEDEE")
        return view
    }
}
