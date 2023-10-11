//
//  PFSelectOptionsView.swift
//  PFUIKit
//
//  Created by Ja on 2023/10/11.
//

import Foundation

public class PFSelectOption: NSObject {
    public var title: String
    public var selected: Bool = false
    
    public required init(title: String, selected: Bool) {
        self.title = title
        self.selected = selected
        super.init()
    }
}

public protocol PFSelectOptionsViewDelegate: NSObjectProtocol {
    func selectOptionsView(_ soView: PFSelectOptionsView, touched option: PFSelectOption)
}

extension PFSelectOptionsViewDelegate {
    func selectOptionsView(_ soView: PFSelectOptionsView, touched option: PFSelectOption) {}
}

public class PFSelectOptionsView: UIView {
    
    public enum SelectionStyle {
    case single, multiple
    }
    
    public enum ContentAlignment {
    case left, right
    }
    
    public weak var delegate: PFSelectOptionsViewDelegate?
    
    public var optionSpace: CGFloat = 20 {
        didSet {
            setNeedsLayout()
        }
    }
    
    public var contentAlignment: PFSelectOptionsView.ContentAlignment = .left {
        didSet {
            setNeedsLayout()
        }
    }
    
    public private(set) var style: PFSelectOptionsView.SelectionStyle = .single
    
    public var options: [PFSelectOption] = [] {
        didSet {
            setupUI()
            setNeedsLayout()
        }
    }
    
    public var selectedOptions: [PFSelectOption] {
        return options.filter { $0.selected == true }
    }
    
    private var btns: [(UIButton, CGSize)] = []
    
    public required init(frame: CGRect, options: [PFSelectOption], style: PFSelectOptionsView.SelectionStyle) {
        super.init(frame: frame)
        self.options = options
        self.style = style
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        var buttonX: CGFloat = 0
        
        var traversalBtns = btns
        if contentAlignment == .right {
            traversalBtns = traversalBtns.reversed()
        }
        for (index, (button, size)) in traversalBtns.enumerated() {
            button.snp.remakeConstraints { make in
                if contentAlignment == .left {
                    make.left.equalToSuperview().offset(buttonX)
                } else {
                    make.right.equalToSuperview().inset(buttonX)
                }
                make.centerY.equalToSuperview()
                make.size.equalTo(size)
            }
            
            buttonX += (optionSpace + size.width)
        }
    }
}

extension PFSelectOptionsView {
    @objc
    func select(sender: UIButton) {
        
        if style == .single {
            if sender.isSelected == false {
                sender.isSelected = true
                btns.forEach { btn, _ in
                    if btn.isEqual(sender) == false {
                        btn.isSelected = false
                    }
                }
            }
        } else {
            if selectedOptions.count > 1 {
                sender.isSelected = !sender.isSelected
            }
        }
        
        options[sender.tag].selected = sender.isSelected
        
        
        delegate?.selectOptionsView(self, touched: options[sender.tag])
    }
}

extension PFSelectOptionsView {
    func setupUI() {
        subviews.forEach { $0.removeFromSuperview() }
        
        for (index, option) in options.enumerated() {
            
            let spaceBetweenTitleAndImage: CGFloat = 3
            let name = option.title
            
            let btn = UIButton(type: .custom)
            btn.tag = index
            btn.titleLabel?.font = UIFont.pingfang(style: .regular, size: 14)
            btn.setTitle(name, for: .normal)
            btn.setTitleColor(.black, for: .normal)
            btn.setImage(UIImage(named: "btn_unselect"), for: .normal)
            btn.setImage(UIImage(named: "btn_select"), for: .selected)
            btn.setImagePosition(position: .left, space: spaceBetweenTitleAndImage)
            btn.addTarget(self, action: #selector(select(sender:)), for: .touchUpInside)
            
            btn.isSelected = option.selected
            
            var btnWidth: CGFloat = 0
            btnWidth = name.strWidth(font: UIFont.pingfang(style: .regular, size: 14), size: CGSize(width: CGFLOAT_MAX, height: 20)) + spaceBetweenTitleAndImage + 20
            
            btns.append((btn, CGSize(width: btnWidth, height: 20)))
            addSubview(btn)
        }
    }
}
