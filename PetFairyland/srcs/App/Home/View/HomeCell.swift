//
//  HomeCell.swift
//  PetFairyland
//
//  Created by Ja on 2023/7/25.
//

import UIKit

class HomeCell: UICollectionViewCell {
    
    var model: HomeItem? {
        didSet {
            if let model = model {
                icon.image = UIImage(named: model.imageStr)
                titleLab.text = model.title
            }
        }
    }
    
    lazy var icon: UIImageView = { UIImageView() }()
    
    lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 16)
        return lab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(hexString: "#f2f2f2")
        layer.cornerRadius = 7
        layer.masksToBounds = true
        
        contentView.addSubview(icon)
        icon.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
            make.size.equalTo(28)
        }
        
        contentView.addSubview(titleLab)
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(self.icon.snp.right).offset(10)
            make.centerY.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
