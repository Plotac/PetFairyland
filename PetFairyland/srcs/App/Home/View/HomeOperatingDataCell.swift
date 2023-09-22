//
//  HomeOperatingDataCell.swift
//  PetFairyland
//
//  Created by Ja on 2023/9/22.
//

import Foundation

class HomeOperatingDataCell: UICollectionViewCell {
    
    var item: HomeOperatingDataItem? {
        didSet {
            if let item = item {
                titleLab.text = item.title
                
                var quantity = "\(item.quantity)"
                var str = "\(quantity)\(item.unit)"
                
                if item.type != .sales {
                    quantity = String(format: "%.f", item.quantity)
                    str = String(format: "%@%@", quantity, item.unit)
                }
                let attText = NSMutableAttributedString(string: str)
                let quantityRange = NSRange(attText.string.range(of: quantity)!, in: attText.string)
                attText.addAttributes([NSAttributedString.Key.font: UIFont.pingfang(style: .medium, size: 22)], range: quantityRange)
                
                subTitleLab.attributedText = attText
                
                gradientLayer.colors = [item.colors.startColor.cgColor, item.colors.endColor.cgColor]
            }
        }
    }
    
    lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = .white
        lab.font = UIFont.pingfang(style: .regular, size: 14)
        return lab
    }()
    
    lazy var subTitleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = .white
        lab.font = UIFont.pingfang(style: .regular, size: 13)
        return lab
    }()
    
    lazy var gradientLayer: CAGradientLayer = {
        let glayer = CAGradientLayer()
        glayer.startPoint = CGPoint(x: 0.00, y: 0.50)
        glayer.endPoint = CGPoint(x: 1.00, y: 0.50)
        glayer.locations = [0, 1]
        return glayer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.masksToBounds = true
        layer.cornerRadius = 10
        
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}

extension HomeOperatingDataCell {
    func setupUI() {
        layer.addSublayer(gradientLayer)
        
        contentView.addSubview(titleLab)
        titleLab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(15)
        }
        
        contentView.addSubview(subTitleLab)
        subTitleLab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLab.snp.bottom).offset(5)
        }
    }
}
