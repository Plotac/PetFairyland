//
//  PFFormHeaderView.swift
//  PFUIKit
//
//  Created by Ja on 2023/10/10.
//

import Foundation

class PFFormHeaderView: UITableViewHeaderFooterView {
    
    lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.font = .pingfang(style: .medium, size: 16)
        return lab
    }()
    
    lazy var cornerBgView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
        addSubview(cornerBgView)
        cornerBgView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(12)
            make.top.bottom.equalToSuperview()
        }
        
        cornerBgView.addSubview(titleLab)
        titleLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.bottom.equalToSuperview()
        }
    }
}
