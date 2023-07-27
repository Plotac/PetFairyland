//
//  DatePickerCell.swift
//  PFUIKit
//
//  Created by Ja on 2023/7/27.
//

import UIKit
import PFUtility

class DatePickerCell: UICollectionViewCell {
    
    var model: DatePickModel? {
        didSet {
            if let model = model {
                dateLab.text = model.exactDate
                weekdayLab.text = model.weekday
                indicator.isHidden = !model.selected
            }
        }
    }
    
    lazy var dateLab: UILabel = {
        let lab = UILabel()
        lab.textAlignment = .center
        lab.font = UIFont.systemFont(ofSize: 15)
        lab.textColor = .black
        return lab
    }()
    
    lazy var weekdayLab: UILabel = {
        let lab = UILabel()
        lab.textAlignment = .center
        lab.font = UIFont.systemFont(ofSize: 15)
        lab.textColor = .black
        return lab
    }()
    
    lazy var indicator: UIView = {
        let view = UIView()
        view.backgroundColor = SystemColor.main
        view.layer.cornerRadius = 1
        view.layer.masksToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(dateLab)
        dateLab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(contentView.snp.centerY).offset(-2)
        }
        
        contentView.addSubview(weekdayLab)
        weekdayLab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(contentView.snp.centerY).offset(2)
        }
        
        contentView.addSubview(indicator)
        indicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.size.equalTo(CGSizeMake(40, 2))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
