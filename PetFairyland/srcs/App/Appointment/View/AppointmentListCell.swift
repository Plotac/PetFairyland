//
//  AppointmentListCell.swift
//  PetFairyland
//
//  Created by Ja on 2023/9/22.
//

import Foundation

class AppointmentListCell: UICollectionViewCell {
    
    lazy var productImageView: UIImageView = {
        return UIImageView()
    }()
    
    lazy var orderStatusLab: UILabel = {
        let lab = UILabel()
        lab.backgroundColor = UIColor(hexString: "#FF8F1F")
        lab.layer.cornerRadius = 3
        lab.layer.masksToBounds = true
        lab.textColor = UIColor(hexString: "#FF8F1F")
        lab.font = UIFont.pingfang(style: .semibold, size: 10)
        return lab
    }()
    
    lazy var newOrderImageView: UIImageView = {
        return UIImageView(image: UIImage(named: "home_al_new_order"))
    }()
    
    lazy var serviceTitleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#333333")
        lab.font = UIFont.pingfang(style: .medium, size: 15)
        return lab
    }()
    
    lazy var petNameLab: UILabel = {
        return makeLabel(text: "宠物：")
    }()
    
    lazy var petNameValueLab: UILabel = {
        return makeLabel(textColorHex: "#333333")
    }()
    
    lazy var masterNameLab: UILabel = {
        return makeLabel(text: "主人：")
    }()
    
    lazy var masterNameValueLab: UILabel = {
        return makeLabel(textColorHex: "#333333")
    }()
    
    lazy var cellPhoneImageView: UIImageView = {
        return UIImageView(image: UIImage(named: "home_al_phone"))
    }()
    
    lazy var serverNameLab: UILabel = {
        return makeLabel(text: "预约老师：")
    }()
    
    lazy var serverNameValueLab: UILabel = {
        return makeLabel(textColorHex: "#333333")
    }()
    
    lazy var serverTimeLab: UILabel = {
        return makeLabel(text: "预约到店时间：")
    }()
    
    lazy var serverTimeValueLab: UILabel = {
        return makeLabel(textColorHex: "#333333")
    }()
    
    lazy var remarkLab: UILabel = {
        return makeLabel(text: "备注：")
    }()
    
    lazy var remarkValueLab: UILabel = {
        return makeLabel(textColorHex: "#333333")
    }()
    
    lazy var cancelBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = UIColor(hexString: "#FDFDFD")
        btn.setTitle("取消预约", for: .normal)
        btn.setTitleColor(UIColor(hexString: "#000000"), for: .normal)
        btn.titleLabel?.font = UIFont.pingfang(style: .medium, size: 12)
        btn.layer.cornerRadius = 4
        btn.layer.masksToBounds = true
        btn.layer.borderColor = SystemColor.main.cgColor
        btn.layer.borderWidth = 1
        return btn
    }()
    
    lazy var completeBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = SystemColor.Button.enable
        btn.setTitle("服务完成", for: .normal)
        btn.setTitleColor(UIColor(hexString: "#000000"), for: .normal)
        btn.titleLabel?.font = UIFont.pingfang(style: .medium, size: 12)
        btn.layer.cornerRadius = 4
        btn.layer.masksToBounds = true
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AppointmentListCell {
    func setupUI() {
        contentView.addSubview(productImageView)
        productImageView.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(10)
            make.size.equalTo(55)
        }
        
        contentView.addSubview(newOrderImageView)
        newOrderImageView.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(-3)
            make.size.equalTo(53)
        }
        
        contentView.addSubview(orderStatusLab)
        orderStatusLab.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.right.equalToSuperview().inset(10)
            make.size.equalTo(CGSize(width: 40, height: 20))
        }
        
        contentView.addSubview(serviceTitleLab)
        serviceTitleLab.snp.makeConstraints { make in
            make.left.equalTo(productImageView.snp.right).offset(10)
            make.centerY.equalTo(orderStatusLab)
        }
        
        contentView.addSubview(petNameLab)
        petNameLab.snp.makeConstraints { make in
            make.left.equalTo(serviceTitleLab)
            make.top.equalTo(serviceTitleLab.snp.bottom).offset(8)
        }
        
        contentView.addSubview(petNameValueLab)
        petNameValueLab.snp.makeConstraints { make in
            make.left.equalTo(petNameLab.snp.right)
            make.centerY.equalTo(petNameLab)
        }
        
        contentView.addSubview(masterNameLab)
        masterNameLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(productImageView.snp.bottom).offset(6)
        }
        
        contentView.addSubview(masterNameValueLab)
        masterNameValueLab.snp.makeConstraints { make in
            make.left.equalTo(masterNameLab.snp.right)
            make.centerY.equalTo(masterNameLab)
        }
        
        contentView.addSubview(serverNameLab)
        serverNameLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(masterNameLab.snp.bottom).offset(6)
        }
        
        contentView.addSubview(serverNameValueLab)
        serverNameValueLab.snp.makeConstraints { make in
            make.left.equalTo(serverNameLab.snp.right)
            make.centerY.equalTo(serverNameLab)
        }
        
        contentView.addSubview(serverTimeLab)
        serverTimeLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(serverNameLab.snp.bottom).offset(6)
        }
        
        contentView.addSubview(serverTimeValueLab)
        serverTimeValueLab.snp.makeConstraints { make in
            make.left.equalTo(serverTimeLab.snp.right)
            make.centerY.equalTo(serverTimeLab)
        }
        
        contentView.addSubview(remarkLab)
        remarkLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(serverTimeLab.snp.bottom).offset(6)
        }
        
        contentView.addSubview(remarkValueLab)
        remarkValueLab.snp.makeConstraints { make in
            make.left.equalTo(remarkLab.snp.right)
            make.centerY.equalTo(remarkLab)
        }
        
        contentView.addSubview(completeBtn)
        completeBtn.snp.makeConstraints { make in
            make.bottom.right.equalToSuperview().inset(10)
            make.size.equalTo(CGSize(width: 80, height: 30))
        }
        
        contentView.addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { make in
            make.centerY.size.equalTo(completeBtn)
            make.right.equalTo(completeBtn.snp.left).offset(-6)
        }
    }
    
    func makeLabel(text: String = "", textColorHex: String = "#999999") -> UILabel {
        let lab = UILabel()
        lab.text = text
        lab.textColor = UIColor(hexString: textColorHex)
        lab.font = UIFont.pingfang(style: .regular, size: 14)
        return lab
    }
}
