//
//  AppointmentListCell.swift
//  PetFairyland
//
//  Created by Ja on 2023/9/22.
//

import Foundation
import Kingfisher

protocol AppointmentListCellDelegate: NSObjectProtocol {
    func call(model: AppointmentListModel)
    func canceled(model: AppointmentListModel)
    func complete(model: AppointmentListModel)
}

class AppointmentListCell: UICollectionViewCell {
    
    var model: AppointmentListModel? {
        didSet {
            if let model = model {
                // 商品图片
                productImageView.kf.setImage(with: model.productUrl.toURL)
                // 商品名称
                serviceTitleLab.text = model.productName
                // 服务宠物
                petNameValueLab.text = model.pet
                
                // 下单用户名称&身份
                masterNameValueLab.text = "\(model.master)(\(model.identityType.description))"
                // 服务老师
                serverNameValueLab.text = model.appointmentServer
                
                // 预约时间
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm"
                formatter.locale = Locale.current
                serverTimeValueLab.text = formatter.string(from: Date(timeIntervalSince1970: Double(model.appointmentTime)))
                
                // 备注
                remarkValueLab.text = model.remark
                
                handleOrder(status: model.status)
                
                newOrderImageView.isHidden = model.type == .old
            }
            
            func handleOrder(status: AppointmentListModel.Status) {
                switch status {
                case .unfinished:
                    orderStatusLab.text = "未完成"
                    orderStatusLab.textColor = UIColor(hexString: "#FF8F1F")
                case .finished:
                    orderStatusLab.text = "已完成"
                    orderStatusLab.textColor = UIColor(hexString: "#1878FF")
                case .canceled:
                    orderStatusLab.text = "已取消"
                    orderStatusLab.textColor = UIColor(hexString: "#FF6565")
                }
                orderStatusLab.backgroundColor = orderStatusLab.textColor.withAlphaComponent(0.2)
                
                cancelBtn.isHidden = !(status == .unfinished)
                completeBtn.isHidden = !(status == .unfinished)
            }
        }
    }
    
    weak var delegate: AppointmentListCellDelegate?
    
    lazy var productImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var orderStatusLab: UILabel = {
        let lab = UILabel()
        lab.backgroundColor = UIColor(hexString: "#FF8F1F")
        lab.layer.cornerRadius = 3
        lab.layer.masksToBounds = true
        lab.textColor = UIColor(hexString: "#FF8F1F")
        lab.font = UIFont.pingfang(style: .semibold, size: 10)
        lab.textAlignment = .center
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
    
    lazy var cellPhoneBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "home_al_phone"), for: .normal)
        btn.addTarget(self, action: #selector(call), for: .touchUpInside)
        return btn
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
        btn.addTarget(self, action: #selector(cancel), for: .touchUpInside)
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
        btn.addTarget(self, action: #selector(complete), for: .touchUpInside)
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
    
    @objc
    func call() {
        if let model = model {
            delegate?.call(model: model)
        }
    }
    
    @objc
    func cancel() {
        if let model = model {
            delegate?.canceled(model: model)
        }
    }
    
    @objc
    func complete() {
        if let model = model {
            delegate?.complete(model: model)
        }
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
        
        contentView.addSubview(cellPhoneBtn)
        cellPhoneBtn.snp.makeConstraints { make in
            make.left.equalTo(masterNameValueLab.snp.right).offset(5)
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
