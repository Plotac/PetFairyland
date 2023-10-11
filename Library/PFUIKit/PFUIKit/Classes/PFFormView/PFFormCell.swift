//
//  PFFormCell.swift
//  PFUIKit
//
//  Created by Ja on 2023/8/1.
//

import UIKit

open class PFFormCell: PFBaseTableViewCell {
    
    var viewModel: PFFormCellViewModel!
    
    open override var cellMargin: CGFloat { 12 }
    
    open var model: PFFormModel? {
        didSet {
            if let model = model {
                viewModel.update(with: model)
                addRightView(model: model)
            }
        }
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        viewModel = PFFormCellViewModel()
        setupUI()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension PFFormCell {
    func setupUI() {
        
        contentView.addSubview(viewModel.titleLab)
        viewModel.titleLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
        }
        
        contentView.addSubview(viewModel.dot)
        viewModel.dot.snp.makeConstraints { make in
            make.bottom.equalTo(viewModel.titleLab.snp.centerY).offset(4)
            make.left.equalTo(viewModel.titleLab.snp.right)
            make.size.equalTo(CGSize(width: 8, height: 10))
        }
        
        contentView.addSubview(viewModel.separatorLine)
        viewModel.separatorLine.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.right.equalToSuperview().inset(12)
            make.left.equalTo(viewModel.titleLab)
            make.height.equalTo(0.7)
        }
        
        viewModel.arrowIcon.isHidden = true
        contentView.addSubview(viewModel.arrowIcon)
        viewModel.arrowIcon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(12)
            make.size.equalTo(16)
        }
    }
    
    func addRightView(model: PFFormModel) {
        
        let classes = [PFFormTextField.self,
                       PFFormTextView.self,
                       PFFormSwitch.self,
                       PFFormPickerLabel.self,
                       PFSelectOptionsView.self]
        
        let views = contentView.subviews.filter { view in
            classes.contains { cls in
                view.isKind(of: cls) == true
            }
        }
        views.forEach { $0.removeFromSuperview() }
        viewModel.arrowIcon.isHidden = true
        
        switch model.rightViewMode {
        case .textfield(let placeholder, let defaultText):
            setupTextField(placeholder: placeholder, defaultText: defaultText)
        case .textView(let placeholder, let defaultText):
            setupTextView(placeholder: placeholder, defaultText: defaultText)
        case .switch:
            break
        case .picker(let defaultText):
            setupPicker(defaultText: defaultText)
        case .options(let titles):
            setupOptions(titles: titles)
        case .custom(let view): view.removeFromSuperview()
            contentView.addSubview(view)
            view.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        case .unknown: break
        }
        
        // TextField设置
        func setupTextField(placeholder: String?, defaultText: String?) {
            if let defaultText = defaultText, defaultText.isEmpty == false {
                viewModel.textField.text = defaultText
            } else {
                viewModel.textField.placeholder = placeholder
            }
            contentView.addSubview(viewModel.textField)
            viewModel.textField.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalToSuperview().offset(model.rightViewLeftOffset)
                make.right.equalToSuperview().inset(15)
                make.height.equalTo(model.rowHeight)
            }
        }
        
        // TextView设置
        func setupTextView(placeholder: String?, defaultText: String?) {
            contentView.addSubview(viewModel.textView)
            if let defaultText = defaultText, defaultText.isEmpty == false {
                viewModel.textView.text = defaultText
                viewModel.textView.textColor = .black
            } else if let placeholder = placeholder, placeholder.isEmpty == false {
                viewModel.textView.text = placeholder
                viewModel.textView.textColor = .placeholderText
            }
            viewModel.textView.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalToSuperview().offset(model.rightViewLeftOffset)
                make.right.equalToSuperview().inset(15)
                make.height.equalTo(model.rowHeight)
            }
        }
        
        // Picker设置
        func setupPicker(defaultText: String?) {
            viewModel.arrowIcon.isHidden = false
            viewModel.pickerLab.text = defaultText
            contentView.addSubview(viewModel.pickerLab)
            viewModel.pickerLab.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.right.equalTo(viewModel.arrowIcon.snp.left)
            }
        }
        
        // Options设置
        func setupOptions(titles: [String]) {
            let options = titles.map { PFSelectOption(title: $0, selected: false)}
            viewModel.optionsView.contentAlignment = .right
            viewModel.optionsView.options = options
            viewModel.optionsView.optionSpace = 15
            contentView.addSubview(viewModel.optionsView)
            viewModel.optionsView.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().inset(15)
                make.size.equalTo(CGSize(width: 200, height: 40))
            }
        }
    }
}
