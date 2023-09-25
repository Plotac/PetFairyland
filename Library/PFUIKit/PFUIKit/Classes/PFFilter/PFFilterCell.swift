//
//  PFFilterCell.swift
//  PFUIKit
//
//  Created by Ja on 2023/9/25.
//

import Foundation

class PFFilterCell: UITableViewCell {
    
    var option: PFFilterOption? {
        didSet {
            if let option = option {
                
                titleLab.text = option.title
                
                self.isSelected = option.selected
                
                if isSelected {
                    if let selectedTextColor = selectedTextColor {
                        titleLab.textColor = selectedTextColor
                    }
                } else {
                    if let normalTextColor = normalTextColor {
                        titleLab.textColor = normalTextColor
                    }
                }
                
            }
        }
    }
    
    var selectedTextColor: UIColor? {
        didSet {
            if option?.selected == true {
                titleLab.textColor = selectedTextColor
            }
        }
    }
    
    var normalTextColor: UIColor? {
        didSet {
            if option?.selected == false {
                titleLab.textColor = normalTextColor
            }
        }
    }
    
    lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.font = .pingfang(style: .regular, size: 14) // 修改该值时，需要同时修改PFFilterBar中，计算文本宽度时用到的值
        lab.textColor = UIColor(hexString: "#808080")
        return lab
    }()
    
    lazy var separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = SystemColor.separator
        return view
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

extension PFFilterCell {
    func setupUI() {
        contentView.addSubview(titleLab)
        titleLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
        }
        
        contentView.addSubview(separatorLine)
        separatorLine.snp.makeConstraints { make in
            make.left.equalTo(titleLab)
            make.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
