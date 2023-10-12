//
//  PFPickerView.swift
//  PFUIKit
//
//  Created by Ja on 2023/10/12.
//

import Foundation

@objc public protocol PFPickerViewDelegate: NSObjectProtocol {
    
    func numberOfRows(inSection section: Int) -> Int
    func pickerView(_ pickerView: PFPickerView, cell: PFPickerCell, at indexPath: IndexPath)
    
    @objc optional func numberOfSections() -> Int
    
    @objc optional func pickerView(_ pickerView: PFPickerView, didSelectRowAt indexPath: IndexPath, select cell: PFPickerCell)
    
    @objc optional func pickerView(_ pickerView: PFPickerView, heightForRowAt indexPath: IndexPath) -> CGFloat
    
    @objc optional func pickerView(_ pickerView: PFPickerView, viewForHeaderInSection section: Int) -> UIView?
    @objc optional func pickerView(_ pickerView: PFPickerView, heightForHeaderInSection section: Int) -> CGFloat
    
    @objc optional func pickerView(_ pickerView: PFPickerView, viewForFooterInSection section: Int) -> UIView?
    @objc optional func pickerView(_ pickerView: PFPickerView, heightForFooterInSection section: Int) -> CGFloat
}

public class PFPickerView: UIView {
    
    public enum SelectionStyle {
        // 单选
        case single
        // 多选
        case multiple
    }
    
    public typealias PFPickerViewEventHandler = () -> Void
    
    public weak var delegate: PFPickerViewDelegate? {
        didSet {
            if let delegate = delegate {
                var totalHeight: CGFloat = 0
                for section in 0..<(delegate.numberOfSections?() ?? 1) {
                    for row in 0..<delegate.numberOfRows(inSection: section) {
                        let indexPath = IndexPath(row: row, section: section)
                        let height = delegate.pickerView?(self, heightForRowAt: indexPath) ?? Constants.defaultRowHeight
                        totalHeight += height
                    }
                }
                whiteBgView.bounds.size.height = Constants.commonMargin +  Constants.titleHeight +  Constants.commonMargin + totalHeight
            }
        }
    }
    
    public private(set) var sectionModels: [PFPickerSectionModel]!
    
    public private(set) var titleLab: UILabel!
    public private(set) var tableView: UITableView!
    
    private var whiteBgView: UIView!
    
    var title: String?
    var selectionStyle: SelectionStyle = .single
    var cancelHandler: PFPickerViewEventHandler?
    var comformHandler: PFPickerViewEventHandler?
    
    var cellClass: PFPickerCell.Type?
    var identifier: String?
    
    public required init(title: String?,
                         selectionStyle: PFPickerView.SelectionStyle,
                         cancelHandler: PFPickerViewEventHandler?,
                         comformHandler: PFPickerViewEventHandler?) {
        super.init(frame: UIScreen.main.bounds)
        self.title = title
        self.selectionStyle = selectionStyle
        self.cancelHandler = cancelHandler
        self.comformHandler = comformHandler
        setupUI()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapEvent))
        tap.delegate = self
        addGestureRecognizer(tap)
        
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func register(_ cellClass: PFPickerCell.Type, forCellReuseIdentifier identifier: String) {
        self.cellClass = cellClass
        self.identifier = identifier
        tableView.register(cellClass, forCellReuseIdentifier: identifier)
    }
}

extension PFPickerView: UITableViewDataSource, UITableViewDelegate {
    
    public func numberOfSections(in tableView: UITableView) -> Int { delegate?.numberOfSections?() ?? 1 }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { delegate?.numberOfRows(inSection: section) ?? 0 }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cellClass = cellClass, let identifier = identifier {
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? PFPickerCell ?? PFPickerCell()
            delegate?.pickerView(self, cell: cell, at: indexPath)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PFPickerCell.reuseIdentity(), for: indexPath) as? PFPickerCell ?? PFPickerCell()
        delegate?.pickerView(self, cell: cell, at: indexPath)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? PFPickerCell {
            cell.selectBtn.isSelected = !cell.selectBtn.isSelected
            cell.isSelected = cell.selectBtn.isSelected
            delegate?.pickerView?(self, didSelectRowAt: indexPath, select: cell)
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        delegate?.pickerView?(self, heightForRowAt: indexPath) ?? Constants.defaultRowHeight
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        delegate?.pickerView?(self, viewForFooterInSection: section)
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        delegate?.pickerView?(self, heightForHeaderInSection: section) ?? 0
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        delegate?.pickerView?(self, viewForFooterInSection: section)
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        delegate?.pickerView?(self, heightForFooterInSection: section) ?? 0
    }
}

public extension PFPickerView {
    func show(animated: Bool) {
        let window = UIApplication.shared.windows.first

        window?.addSubview(self)
        window?.bringSubviewToFront(self)

        if animated {
            UIView.animate(withDuration: 0.3) {
                self.backgroundColor = SystemColor.mask
                self.whiteBgView.frame.origin.y = self.bounds.size.height - self.whiteBgView.bounds.size.height
            }
        } else {
            whiteBgView.frame.origin.y = self.bounds.size.height - whiteBgView.bounds.size.height
        }
    }
    
    func hide(animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.2) {
                self.backgroundColor = .clear
                self.whiteBgView.frame.origin.y = self.bounds.size.height
            } completion: { _ in
                self.removeFromSuperview()
            }
        } else {
            backgroundColor = .clear
            removeFromSuperview()
        }
    }
}

extension PFPickerView {
    @objc
    func cancelEvent() {
        hide(animated: true)
    }
    
    @objc
    func confirmEvent() {
        hide(animated: true)
    }
    
    @objc
    func tapEvent() {
        hide(animated: true)
    }
}

extension PFPickerView: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if let view = touch.view, view.isDescendant(of: whiteBgView) {
            return false
        }
        return true
    }
}

extension PFPickerView {
    func setupUI() {
        
        self.backgroundColor = .clear
        
        whiteBgView = UIView(frame: CGRectMake(0, bounds.size.height, bounds.size.width, 200))
        whiteBgView.layer.cornerRadius = 8
        whiteBgView.layer.masksToBounds = true
        whiteBgView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        whiteBgView.backgroundColor = .white
        addSubview(whiteBgView)
        
        titleLab = UILabel()
        titleLab.frame.origin.y = Constants.commonMargin
        titleLab.textAlignment = .center
        titleLab.text = self.title
        titleLab.font = .pingfang(style: .medium, size: 15)
        titleLab.sizeToFit()
        titleLab.bounds.size.height = Constants.titleHeight
        titleLab.frame.origin.x = center.x - (titleLab.bounds.size.width) / 2
        whiteBgView.addSubview(titleLab)
        
        let cancelBtn = UIButton(type: .custom)
        cancelBtn.frame = CGRect(x: Constants.commonMargin, y: CGRectGetMidY(titleLab.frame) - 30 / 2, width: 40, height: 30)
        cancelBtn.titleLabel?.font = .pingfang(style: .regular, size: 14)
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.setTitleColor(UIColor(hexString: "#808080"), for: .normal)
        cancelBtn.addTarget(self, action: #selector(cancelEvent), for: .touchUpInside)
        whiteBgView.addSubview(cancelBtn)
        
        let confirmBtn = UIButton(type: .custom)
        confirmBtn.frame = CGRect(x: CGRectGetMaxX(whiteBgView.frame) - 40 - Constants.commonMargin, y: CGRectGetMidY(titleLab.frame) - 30 / 2, width: 40, height: 30)
        confirmBtn.titleLabel?.font = .pingfang(style: .regular, size: 14)
        confirmBtn.setTitle("确认", for: .normal)
        confirmBtn.setTitleColor(SystemColor.main, for: .normal)
        confirmBtn.addTarget(self, action: #selector(confirmEvent), for: .touchUpInside)
        whiteBgView.addSubview(confirmBtn)
        
        let separatorLine = UIView(frame: CGRect(x: 0, y: CGRectGetMaxY(titleLab.frame) + Constants.commonMargin, width: CGRectGetWidth(whiteBgView.frame), height: 0.7))
        separatorLine.backgroundColor = SystemColor.separator
        whiteBgView.addSubview(separatorLine)
        
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        tableView.register(PFPickerCell.self, forCellReuseIdentifier: PFPickerCell.reuseIdentity())
        whiteBgView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(separatorLine.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
}

fileprivate struct Constants {
    static let commonMargin: CGFloat = 15
    static let titleHeight: CGFloat = 20
    static let defaultRowHeight: CGFloat = 50
}
