//
//  HomeFunctionCell.swift
//  PetFairyland
//
//  Created by Ja on 2023/7/25.
//

import UIKit

class HomeFunctionCell: UICollectionViewCell {
    
    var item: HomeFunctionItem? {
        didSet {
            if let item = item {
                icon.image = UIImage(named: item.imageStr)
                titleLab.text = item.title
            }
        }
    }
    
    lazy var icon: UIImageView = { UIImageView() }()
    
    lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.pingfang(style: .regular, size: 14)
        return lab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(icon)
        icon.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.size.equalTo(40)
        }
        
        contentView.addSubview(titleLab)
        titleLab.snp.makeConstraints { make in
            make.centerX.bottom.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

