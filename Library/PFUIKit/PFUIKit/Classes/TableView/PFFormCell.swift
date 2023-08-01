//
//  PFFormCell.swift
//  PFUIKit
//
//  Created by Ja on 2023/8/1.
//

import UIKit

open class PFFormCell: UITableViewCell {
    
    open var model: PFFormModel? {
        didSet {
            if let model = model {
                updateUI(model: model)
            }
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
        lab.font = UIFont.systemFont(ofSize: 16)
        return lab
    }()
    
    lazy var textField: UITextField = {
        let tf = UITextField()
        tf.textColor = .black
        tf.font = UIFont.systemFont(ofSize: 16)
        return tf
    }()
    
    lazy var textView: UITextView = {
        let tv = UITextView()
        tv.delegate = self
        tv.textColor = .black
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.textContainerInset = UIEdgeInsets(top: 15, left: -5, bottom: -15, right: -5)
        return tv
    }()
    
    lazy var separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#D3D3D3", alpha: 0.7)
        return view
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(model: PFFormModel) {
        
        dot.isHidden = !model.isNecessary
        
        titleLab.text = model.title
        titleLab.snp.remakeConstraints { make in
            if dot.isHidden {
                make.left.equalToSuperview().offset(12 + 8 + 2)
            } else {
                make.left.equalTo(dot.snp.right).offset(2)
            }
            if model.isOriginalRowHeight {
                make.centerY.equalToSuperview()
            } else {
                make.top.equalToSuperview().offset(15)
            }
        }
        
        textField.isHidden = !(model.editMode == .textfield)
        textField.placeholder = model.placeholder
        textField.snp.remakeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(model.editViewLeftOffset)
            make.right.equalToSuperview().inset(15)
            make.height.equalTo(model.rowHeight)
        }
        
        textView.isHidden = model.editMode == .textfield
        if textView.isHidden == false, model.placeholder.isEmpty == false {
            textView.text = model.placeholder
            textView.textColor = .placeholderText
        } else {
            textView.text = ""
            textView.textColor = .black
        }
        textView.snp.remakeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(model.editViewLeftOffset)
            make.right.equalToSuperview().inset(15)
            make.height.equalTo(model.rowHeight)
        }
    }
}

extension PFFormCell: UITextViewDelegate {
    public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        textView.text = ""
        textView.textColor = .black
        return true
    }
    
    public func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if textView.text.isEmpty {
            textView.text = model?.placeholder
            textView.textColor = .placeholderText
        }
        return true
    }
}

private extension PFFormCell {
    func setupUI() {
        contentView.addSubview(dot)
        dot.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.snp.centerY)
            make.left.equalToSuperview().offset(12)
            make.size.equalTo(CGSize(width: 8, height: 10))
        }
        
        contentView.addSubview(titleLab)
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(dot.snp.right).offset(2)
            make.centerY.equalToSuperview()
        }
        
        contentView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(80)
            make.right.equalToSuperview().inset(15)
            make.height.equalTo(0)
        }
        
        contentView.addSubview(textView)
        textView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(80)
            make.right.equalToSuperview().inset(15)
            make.height.equalTo(0)
        }
        
        contentView.addSubview(separatorLine)
        separatorLine.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.right.equalTo(textField)
            make.height.equalTo(0.5)
        }
    }
}
