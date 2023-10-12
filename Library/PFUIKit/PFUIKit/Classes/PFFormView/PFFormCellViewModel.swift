//
//  PFFormCellViewModel.swift
//  PFUIKit
//
//  Created by Ja on 2023/10/10.
//

import Foundation

class PFFormCellViewModel: NSObject  {
    
    var model: PFFormModel? {
        didSet {
            
        }
    }
    
    lazy var dot: UILabel = {
        let lab = UILabel()
        lab.text = "*"
        lab.textColor = .red
        lab.font = UIFont.systemFont(ofSize: 15)
        return lab
    }()
    
    lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.font = .pingfang(style: .regular, size: 14)
        return lab
    }()
    
    lazy var textField: PFFormTextField = {
        let tf = PFFormTextField()
        tf.tintColor = SystemColor.main
        tf.textAlignment = .right
        tf.textColor = .black
        tf.font = .pingfang(style: .regular, size: 14)
        return tf
    }()
    
    lazy var pickerLab: PFFormPickerLabel = {
        let lab = PFFormPickerLabel()
        lab.font = .pingfang(style: .regular, size: 14)
        lab.textColor = UIColor(hexString: "#CCCCCC")
        return lab
    }()
    
    lazy var textView: PFFormTextView = {
        let tv = PFFormTextView()
        tv.delegate = self
        tv.textColor = .black
        tv.tintColor = SystemColor.main
        tv.font = .pingfang(style: .regular, size: 14)
        tv.textContainer.lineFragmentPadding = 0
        return tv
    }()
    
    lazy var optionsView: PFSelectOptionsView = {
        let view = PFSelectOptionsView(frame: .zero, options: [], style: .single)
        view.delegate = self
        return view
    }()
    
    lazy var arrowIcon: UIImageView = {
        return UIImageView(image: UIImage(named: "common_arrow_right"))
    }()
    
    lazy var separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = SystemColor.separator
        return view
    }()
}

extension PFFormCellViewModel: PFSelectOptionsViewDelegate {
    func selectOptionsView(_ soView: PFSelectOptionsView, touched option: PFSelectOption) {
        
    }
}

extension PFFormCellViewModel: UITextViewDelegate {
    public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        textView.text = ""
        textView.textColor = .black
        return true
    }
    
    public func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if textView.text.isEmpty {
            textView.text = model?.rightViewMode.placeholder
            textView.textColor = .placeholderText
        }
        return true
    }
}

extension PFFormCellViewModel {
    func update(with model: PFFormModel) {
        
        dot.isHidden = !model.isNecessary
        
        titleLab.text = model.title
        titleLab.snp.remakeConstraints { make in
            make.left.equalToSuperview().offset(12)
            if model.isOriginalRowHeight {
                make.centerY.equalToSuperview()
            } else {
                make.top.equalToSuperview().offset(15)
            }
        }
        
        separatorLine.isHidden = !model.showSeparatorLine
    }
}
