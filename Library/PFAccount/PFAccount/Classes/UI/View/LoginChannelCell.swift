//
//  LoginChannelCell.swift
//  PFAccount
//
//  Created by Ja on 2023/7/26.
//

import UIKit

class LoginChannelCell: UICollectionViewCell {
    
    var channel: LoginChannel? {
        didSet {
            if let channel = channel {
                icon.image = UIImage(named: channel.imageStr)
            }
        }
    }
    
    lazy var icon: UIImageView = {
        return UIImageView()
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(icon)
        icon.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(42)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
