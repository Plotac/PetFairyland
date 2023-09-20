//
//  StoreListCell.swift
//  PFAccount
//
//  Created by Ja on 2023/9/20.
//

import UIKit

class StoreListCell: UITableViewCell {
    
    lazy var selectBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "btn_unselect"), for: .normal)
        btn.setImage(UIImage(named: "btn_select"), for: .selected)
        return btn
    }()
    
    lazy var nameLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#000000")
        lab.font = UIFont.pingfang(style: .regular, size: 14)
        return lab
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StoreListCell {
    func setupUI() {
        contentView.addSubview(selectBtn)
        selectBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(-5)
            make.centerY.equalToSuperview()
            make.size.equalTo(22)
        }
        
        contentView.addSubview(nameLab)
        nameLab.snp.makeConstraints { make in
            make.left.equalTo(selectBtn.snp.right).offset(5)
            make.centerY.equalToSuperview()
        }
    }
}
