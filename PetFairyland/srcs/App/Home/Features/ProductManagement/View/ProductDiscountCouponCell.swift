//
//  ProductDiscountCouponCell.swift
//  PetFairyland
//
//  Created by Ja on 2023/10/13.
//

import Foundation

class ProductDiscountCouponCell: PFPickerCell {
    
    var model: DiscountCouponModel? {
        didSet {
            if let model = model {
                discountLab.backgroundColor = UIColor(hexString: model.status == .enable ? "#EFC275" : "#CCCCCC")
                if model.type == .discount {
                    discountLab.text = "\(model.discount)\(model.unit)"
                } else {
                    let text = String(format: "%@%.f", model.unit, model.discount)
                    let attText = NSMutableAttributedString(string: text)
                    let unitRange = NSRange(attText.string.range(of: model.unit)!, in: attText.string)
                    attText.addAttributes([NSAttributedString.Key.font: UIFont.pingfang(style: .semibold, size: 14)], range: unitRange)
                    discountLab.attributedText = attText
                }
                
                let typeText = model.type == .moneyOff ? "满减券" : "折扣券"
                couponTypeLab.text = typeText
                couponTypeLab.backgroundColor = discountLab.backgroundColor
                let typeTextWidth = typeText.strWidth(font: couponTypeLab.font, size: CGSize(width: CGFLOAT_MAX, height: 20)) + 12
                couponTypeLab.snp.remakeConstraints { make in
                    make.left.equalTo(discountLab.snp.right).offset(15)
                    make.top.equalTo(discountLab).offset(5)
                    make.height.equalTo(20)
                    make.width.equalTo(typeTextWidth)
                }
                
                titleLab.text = model.title
                
                if model.status == .disabled {
                    desLab.text = "本商品不适用"
                } else {
                    desLab.text = model.sharedWithMemberPrice ? "" : "不可与会员价同享"
                }
                
                validityLab.text = model.validityType.description
            }
        }
    }
    
    lazy var discountLab: UILabel = {
        let lab = UILabel()
        lab.textAlignment = .center
        lab.backgroundColor = UIColor(hexString: "#EFC275")
        lab.textColor = .white
        lab.font = .pingfang(style: .semibold, size: 36)
        return lab
    }()
    
    lazy var couponTypeLab: UILabel = {
        let lab = UILabel()
        lab.layer.cornerRadius = 10
        lab.layer.masksToBounds = true
        lab.textAlignment = .center
        lab.backgroundColor = UIColor(hexString: "#EFC275")
        lab.textColor = .white
        lab.font = .pingfang(style: .medium, size: 10)
        return lab
    }()
    
    lazy var desLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#808080")
        lab.font = .pingfang(style: .regular, size: 12)
        return lab
    }()
    
    lazy var validityLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#808080")
        lab.font = .pingfang(style: .regular, size: 12)
        return lab
    }()
    
    override func setupUI() {
        super.setupUI()
        contentView.addSubview(discountLab)
        discountLab.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().inset(10)
            make.width.equalTo(100)
        }
        
        contentView.addSubview(couponTypeLab)
        couponTypeLab.snp.makeConstraints { make in
            make.left.equalTo(discountLab.snp.right).offset(15)
            make.top.equalTo(discountLab).offset(5)
        }
        
        titleLab.textColor = UIColor(hexString: "#000000")
        titleLab.font = .pingfang(style: .semibold, size: 16)
        titleLab.snp.remakeConstraints { make in
            make.left.equalTo(couponTypeLab.snp.right).offset(10)
            make.centerY.equalTo(couponTypeLab)
        }
        
        contentView.addSubview(desLab)
        desLab.snp.makeConstraints { make in
            make.left.equalTo(couponTypeLab)
            make.top.equalTo(couponTypeLab.snp.bottom).offset(10)
        }
        
        contentView.addSubview(validityLab)
        validityLab.snp.makeConstraints { make in
            make.left.equalTo(couponTypeLab)
            make.bottom.equalTo(discountLab).inset(5)
        }
        
        separatorLine.snp.remakeConstraints { make in
            make.left.equalTo(discountLab)
            make.right.bottom.equalToSuperview()
            make.height.equalTo(0.7)
        }
    }
    
}
