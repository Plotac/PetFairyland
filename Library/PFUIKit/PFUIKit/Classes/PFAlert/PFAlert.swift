//
//  PFAlert.swift
//  PFUIKit
//
//  Created by Ja on 2023/9/15.
//

import Foundation

public class PFAlert: UIView {

    public enum Style {
        case alert, actionSheet
    }

    /// 风格
    public var style: PFAlert.Style = .alert

    /// 左右两侧间距
    public var margin: CGFloat = 45 {
        didSet {
            setNeedsLayout()
        }
    }

    /// 按钮之间的间距
    public var actionSpacing: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    /// 按钮距离底部的间距
    public var actionBottomSpaceing: CGFloat = 5 {
        didSet {
            setNeedsLayout()
        }
    }

    /// 提示框相对于屏幕中心的偏移量（该值越大，越向上偏移越多）
    public var yOffset: CGFloat = 20 {
        didSet {
            if bgView != nil {
                bgView.snp.updateConstraints { make in
                    make.centerY.equalToSuperview().offset(-yOffset)
                }
            }
        }
    }

    /// 是否显示按钮之间的水平分隔线
    public var showHorizontalActionSeparator: Bool = true
    
    /// 是否显示按钮之间的垂直分隔线（仅当style == .alert时有效）
    public var showVerticalActionSeparator: Bool = true

    public var title: String? {
        didSet {
            titleLab.text = title
        }
    }

    public var message: String? {
        didSet {
            messageTextView.text = message
        }
    }
    
    public var titleAlignment: NSTextAlignment = .center {
        didSet {
            titleLab.textAlignment = titleAlignment
        }
    }
    
    public var messageAlignment: NSTextAlignment = .center {
        didSet {
            messageTextView.textAlignment = messageAlignment
        }
    }

    private var titleLab: UILabel!
    private var messageTextView: UITextView!

    private var bgView: UIView!

    private var actions: [PFAlertAction] = []
    private var actionBtns: [UIButton] = []
    private var gradientControls: [(UIButton, CAGradientLayer)] = []

    public required init(title: String?, message: String?, style: PFAlert.Style) {
        super.init(frame: UIScreen.main.bounds)
        self.title = title
        self.message = message
        self.style = style
        setupUI()
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        updateSubViewsConstraints()
    }
}

extension PFAlert {

    public func add(actions: [PFAlertAction]) {
        self.actions = actions

        var lastBtn: UIButton?
        for (index, action) in actions.enumerated() {
            let btn = UIButton(type: .custom)

            var _cornerRadius: CGFloat = PFAlertAction.UIConstants.Common.cornerRadius
            var _backgroundColor: UIColor = .black
            var _font: UIFont = .systemFont(ofSize: 17)
            var _backgroundGradientColors: (startColor: UIColor?, endColor: UIColor?)? = (nil, nil)
            var _textColor: UIColor = .white
            switch action.style {
            case .confirm:
                _backgroundColor = PFAlertAction.UIConstants.Confirm.backgroundColor
                _backgroundGradientColors = PFAlertAction.UIConstants.Confirm.backgroundGradientColors
                _font = PFAlertAction.UIConstants.Confirm.font
                _textColor = PFAlertAction.UIConstants.Confirm.textColor
            case .cancel:
                _backgroundColor = PFAlertAction.UIConstants.Cancel.backgroundColor
                _backgroundGradientColors = PFAlertAction.UIConstants.Cancel.backgroundGradientColors
                _font = PFAlertAction.UIConstants.Cancel.font
                _textColor = PFAlertAction.UIConstants.Cancel.textColor
            case let .other(cornerRadius, backgroundColor, backgroundGradientColors, textColor, font):
                _cornerRadius = cornerRadius
                _backgroundColor = backgroundColor
                _backgroundGradientColors = backgroundGradientColors
                _textColor = textColor
                _font = font
            }
            btn.backgroundColor = _backgroundColor
            btn.titleLabel?.font = _font
            btn.setTitle(action.title, for: .normal)
            btn.setTitleColor(_textColor, for: .normal)
            btn.layer.cornerRadius = _cornerRadius
            btn.layer.masksToBounds = true
            btn.addTarget(self, action: #selector(alertEvent(sender:)), for: .touchUpInside)
            btn.tag = 100 + index

            if let startColor = _backgroundGradientColors?.startColor, let endColor = _backgroundGradientColors?.endColor {
                let glayer = CAGradientLayer()
                glayer.startPoint = CGPoint(x: 0.00, y: 0.50)
                glayer.endPoint = CGPoint(x: 1.00, y: 0.50)
                glayer.colors = [startColor.cgColor, endColor.cgColor]
                glayer.locations = [0, 1]
                btn.layer.addSublayer(glayer)

                gradientControls.append((btn, glayer))
            }
            btn.bringSubviewToFront(btn.titleLabel!)// swiftlint:disable:this force_unwrapping
            bgView.addSubview(btn)
            
            if style == .alert {
                let btnSize = action.size == .zero ? CGSize(width: (UIScreen.main.bounds.size.width - margin * 2) / CGFloat(actions.count), height: 45) : action.size
                
                let bgWidth: CGFloat = UIScreen.main.bounds.size.width - margin * 2
                let totalSpace: CGFloat = CGFloat((actions.count - 1)) * actionSpacing
                let totalBtnWidth: CGFloat = CGFloat(actions.count) * btnSize.width
                let startX: CGFloat = (bgWidth - totalBtnWidth - totalSpace) / 2
                btn.snp.makeConstraints { make in
                    make.left.equalToSuperview().offset(startX + CGFloat(index) * (btnSize.width + actionSpacing))
                    make.top.equalTo(messageTextView.snp.bottom).offset(20)
                    make.size.equalTo(btnSize)
                }
            } else if style == .actionSheet {
                let btnSize = action.size == .zero ? CGSize(width: UIScreen.main.bounds.size.width - margin * 2, height: 45) : action.size
                
                btn.snp.makeConstraints { make in
                    make.centerX.equalToSuperview()
                    make.top.equalTo(messageTextView.snp.bottom).offset(20 + CGFloat(index) * (btnSize.height + actionSpacing + (showHorizontalActionSeparator ? 0.5 : 0)))
                    make.size.equalTo(btnSize)
                }
            }

            lastBtn = btn

            actionBtns.append(btn)
            
            
            if showVerticalActionSeparator {
                if style == .alert, index != actions.count - 1 {
                    let separator = makeSeparatorLine()
                    bgView.addSubview(separator)
                    bgView.bringSubviewToFront(separator)
                    separator.snp.makeConstraints { make in
                        make.left.equalTo(btn.snp.right).offset(-0.5)
                        make.top.bottom.equalTo(btn)
                        make.width.equalTo(1)
                    }
                }
            }
            
            if showHorizontalActionSeparator {
                if style == .actionSheet, index != actions.count - 1 {
                    let separator = makeSeparatorLine()
                    bgView.addSubview(separator)
                    bgView.bringSubviewToFront(separator)
                    separator.snp.makeConstraints { make in
                        make.left.right.equalToSuperview()
                        make.top.equalTo(btn.snp.bottom)
                        make.height.equalTo(0.5)
                    }
                }
            }
            
        }

        if let lastBtn = lastBtn {
            bgView.snp.remakeConstraints { make in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview().offset(-yOffset)
                make.left.right.equalToSuperview().inset(margin)
                make.bottom.equalTo(lastBtn.snp.bottom).offset(actionBottomSpaceing)
            }
            
            if showHorizontalActionSeparator {
                if style == .alert {
                    let separator = makeSeparatorLine()
                    bgView.addSubview(separator)
                    separator.snp.makeConstraints { make in
                        make.left.right.equalToSuperview()
                        make.bottom.equalTo(lastBtn.snp.top)
                        make.height.equalTo(0.5)
                    }
                }
            }
        }
    }

    /// 展示PFAlert
    public func show() {
        let window = UIApplication.shared.windows.first
        window?.addSubview(self)
        UIView.animate(withDuration: 0.1, delay: 0, options: UIView.AnimationOptions.curveLinear) {
            self.backgroundColor = .black.withAlphaComponent(0.8)
        } completion: { _ in

        }
    }

    /// 隐藏PFAlert
    @objc
    public func dismiss() {
        removeFromSuperview()
    }
}

extension PFAlert {
    @objc
    func alertEvent(sender: UIButton) {
        if let action = actions.safeIndex(newIndex: sender.tag - 100) {
            action.handler?(action)
            dismiss()
        }
    }
}

private extension PFAlert {
    func setupUI() {
        backgroundColor = .clear

        bgView = UIView()
        bgView.layer.cornerRadius = 11
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = .white
        addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-yOffset)
            make.left.right.equalToSuperview().inset(margin)
        }

        titleLab = UILabel()
        titleLab.textAlignment = titleAlignment
        titleLab.text = title
        titleLab.font = UIFont.pingfang(style: .medium, size: 17)
        titleLab.textColor = UIColor(hexString: "#000000")
        titleLab.numberOfLines = 1
        titleLab.isHidden = !(title != nil)
        bgView.addSubview(titleLab)
        titleLab.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10)
            make.top.equalToSuperview().offset(25)
        }

        messageTextView = UITextView()
        messageTextView.text = message
        messageTextView.backgroundColor = .clear
        messageTextView.font = UIFont.pingfang(style: .regular, size: 14)
        messageTextView.textColor = UIColor(hexString: "#000000")
        messageTextView.textContainer.lineFragmentPadding = 0
        messageTextView.isScrollEnabled = false
        messageTextView.isEditable = false
        messageTextView.textContainerInset = .zero
        messageTextView.textAlignment = messageAlignment
        messageTextView.showsVerticalScrollIndicator = false
        messageTextView.showsHorizontalScrollIndicator = false
        bgView.addSubview(messageTextView)

        var height: CGFloat = 0
        if let msg = message, msg.isEmpty == false {
            let screentSize = UIScreen.main.bounds.size
            let msgRect = NSString(string: message ?? "").boundingRect(with: CGSize(width: screentSize.width - margin * 2 - (16 + 12), height: CGFLOAT_MAX), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: messageTextView.font!], context: nil)// swiftlint:disable:this force_unwrapping
            height = ceil(msgRect.height)
        }

        messageTextView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.right.equalToSuperview().inset(12)
            if titleLab.isHidden {
                make.top.equalToSuperview().offset(30)
            } else {
                make.top.equalTo(titleLab.snp.bottom).offset(10)
            }
            make.height.equalTo(height)
        }

        bgView.snp.makeConstraints { make in
            make.bottom.equalTo(messageTextView.snp.bottom).offset(actionBottomSpaceing)
        }
    }

    func updateSubViewsConstraints() {
        for (index, btn) in actionBtns.enumerated() {
            btn.layoutIfNeeded()

            if style == .alert {
                let bgWidth: CGFloat = UIScreen.main.bounds.size.width - margin * 2
                let totalSpace: CGFloat = CGFloat((actionBtns.count - 1)) * actionSpacing
                let totalBtnWidth: CGFloat = CGFloat(actionBtns.count) * btn.bounds.size.width
                let startX: CGFloat = (bgWidth - totalBtnWidth - totalSpace) / 2
                btn.snp.remakeConstraints { make in
                    make.left.equalToSuperview().offset(startX + CGFloat(index) * (btn.bounds.size.width + actionSpacing))
                    make.top.equalTo(messageTextView.snp.bottom).offset(20)
                    make.size.equalTo(btn.bounds.size)
                }
            } else if style == .actionSheet {
                btn.snp.remakeConstraints { make in
                    make.centerX.equalToSuperview()
                    make.top.equalTo(messageTextView.snp.bottom).offset(20 + CGFloat(index) * (btn.bounds.size.height + actionSpacing + (showHorizontalActionSeparator ? 0.5 : 0)))
                    make.size.equalTo(btn.bounds.size)
                }
            }

        }
        if let lastBtn = actionBtns.last {
            bgView.snp.remakeConstraints { make in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview().offset(-yOffset)
                make.left.right.equalToSuperview().inset(margin)
                make.bottom.equalTo(lastBtn.snp.bottom).offset(actionBottomSpaceing)
            }
        }

        gradientControls.forEach { button, layer in
            layer.frame = button.bounds
        }
    }
    
    func makeSeparatorLine() -> UIView {
        let separator = UIView()
        separator.backgroundColor = UIColor(hexString: "#EDEDEE")
        return separator
    }
}
