//
//  ProductManageCell.swift
//  PetFairyland
//
//  Created by Ja on 2023/10/9.
//

import Foundation

class ProductManageCell: PFBaseTableViewCell {
    
    var model: ProductManageModel? {
        didSet {
            if let model = model {
                titleLab.text = model.name
                priceLab.text = "¥\(model.price)"
                membershipPriceLab.text = "¥\(model.membershipPrice)"
                membershipPriceLab.isHidden = model.membershipPrice == 0
                serverTimeValueLab.text = "\(model.serviceTime)"
                salesVolumeValueLab.text = "\(model.salesVolume)"
                
                addButtons(status: model.status)
            }
        }
    }
    
    override var cellMargin: CGFloat { 12 }
    
    override var lineSpacing: CGFloat { 10 }
    
    lazy var productImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#333333")
        lab.font = UIFont.pingfang(style: .medium, size: 14)
        return lab
    }()
    
    lazy var priceLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#333333")
        lab.font = UIFont.pingfang(style: .medium, size: 14)
        return lab
    }()
    
    lazy var membershipPriceLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#CBB5A5")
        lab.font = UIFont.pingfang(style: .medium, size: 14)
        return lab
    }()
    
    lazy var serverTimeLab: UILabel = {
        return makeLabel(text: "服务时间：")
    }()
    
    lazy var serverTimeValueLab: UILabel = {
        return makeLabel(textColorHex: "#333333")
    }()
    
    lazy var salesVolumeLab: UILabel = {
        return makeLabel(text: "总销量：")
    }()
    
    lazy var salesVolumeValueLab: UILabel = {
        return makeLabel(textColorHex: "#333333")
    }()
    
    lazy var separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = SystemColor.separator
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProductManageCell {
    func setupUI() {
        contentView.addSubview(productImageView)
        productImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.equalToSuperview().offset(10)
            make.size.equalTo(80)
        }
        
        contentView.addSubview(titleLab)
        titleLab.snp.makeConstraints { make in
            make.top.equalTo(productImageView).offset(3)
            make.left.equalTo(productImageView.snp.right).offset(10)
        }
        
        contentView.addSubview(priceLab)
        priceLab.snp.makeConstraints { make in
            make.centerY.equalTo(titleLab)
            make.right.equalToSuperview().inset(10)
        }
        
        contentView.addSubview(membershipPriceLab)
        membershipPriceLab.snp.makeConstraints { make in
            make.top.equalTo(priceLab.snp.bottom).offset(8)
            make.right.equalToSuperview().inset(10)
        }
        
        contentView.addSubview(serverTimeLab)
        serverTimeLab.snp.makeConstraints { make in
            make.left.equalTo(titleLab)
            make.top.equalTo(titleLab.snp.bottom).offset(10)
        }
        
        contentView.addSubview(serverTimeValueLab)
        serverTimeValueLab.snp.makeConstraints { make in
            make.left.equalTo(serverTimeLab.snp.right)
            make.centerY.equalTo(serverTimeLab)
        }
        
        contentView.addSubview(salesVolumeLab)
        salesVolumeLab.snp.makeConstraints { make in
            make.left.equalTo(titleLab)
            make.top.equalTo(serverTimeLab.snp.bottom).offset(10)
        }
        
        contentView.addSubview(salesVolumeValueLab)
        salesVolumeValueLab.snp.makeConstraints { make in
            make.left.equalTo(salesVolumeLab.snp.right)
            make.centerY.equalTo(salesVolumeLab)
        }
        
        contentView.addSubview(separatorLine)
        separatorLine.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(productImageView.snp.bottom).offset(15)
            make.height.equalTo(1)
        }
    }
    
    func addButtons(status: ProductManageModel.Status) {
        
        
        var titles = ["用户端预览", "编辑", "下线"]
        if status == .offline {
            titles = ["用户端预览", "编辑", "重新上线", "删除"]
        }
        
        contentView.subviews.forEach { if $0.tag >= 100 { $0.removeFromSuperview() } }
        
        let btnWidth: CGFloat = (Screen.width - cellMargin * 2 - (CGFloat(titles.count) - 1) * 1) / CGFloat(titles.count)
    
        for (index, title) in titles.enumerated() {

            let btn = UIButton(type: .custom)
            btn.tag = 100 + index
            btn.setTitle(title, for: .normal)
            btn.setTitleColor(.black, for: .normal)
            btn.titleLabel?.font = .pingfang(style: .medium, size: 14)
            contentView.addSubview(btn)
            btn.snp.remakeConstraints { make in
                make.left.equalToSuperview().offset(CGFloat(index) * (btnWidth + 1))
                make.bottom.equalToSuperview()
                make.size.equalTo(CGSize(width: btnWidth, height: 45))
            }

            if index != titles.count - 1 {
                let separator = UIView()
                separator.tag = 200 + index
                separator.backgroundColor = SystemColor.separator
                contentView.addSubview(separator)
                separator.snp.remakeConstraints { make in
                    make.left.equalTo(btn.snp.right)
                    make.top.equalTo(separatorLine.snp.bottom)
                    make.bottom.equalToSuperview()
                    make.width.equalTo(1)
                }
            }
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
