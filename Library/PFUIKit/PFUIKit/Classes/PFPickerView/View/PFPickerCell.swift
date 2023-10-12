//
//  PFPickerCell.swift
//  PFUIKit
//
//  Created by Ja on 2023/10/12.
//

import Foundation

public protocol PFPickerCellDelegate: NSObjectProtocol {
    func selected(cell: PFPickerCell)
}

open class PFPickerCell: PFBaseTableViewCell {
    
    public weak var delegate: PFPickerCellDelegate?
    
    public lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#999999")
        lab.font = UIFont.pingfang(style: .regular, size: 14)
        return lab
    }()
    
    public lazy var separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = SystemColor.separator
        return view
    }()
    
    public lazy var selectBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "btn_unselect"), for: .normal)
        btn.setImage(UIImage(named: "btn_select"), for: .selected)
        btn.addTarget(self, action: #selector(select(sender:)), for: .touchUpInside)
        return btn
    }()
    
    open override func setupUI() {
        
        contentView.addSubview(titleLab)
        titleLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
        }
        contentView.addSubview(separatorLine)
        separatorLine.snp.makeConstraints { make in
            make.left.equalTo(titleLab)
            make.right.bottom.equalToSuperview()
            make.height.equalTo(0.7)
        }
        
        contentView.addSubview(selectBtn)
        selectBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
            make.size.equalTo(30)
        }
    }
    
    @objc func select(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.isSelected = sender.isSelected
        
        delegate?.selected(cell: self)
    }
}
