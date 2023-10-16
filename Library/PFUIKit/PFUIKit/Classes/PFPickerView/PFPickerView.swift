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
    
    public typealias PFPickerViewCancelEventHandler = () -> Void
    public typealias PFPickerViewConfirmEventHandler = (_ selectedIndexPaths: [IndexPath]) -> Void
    
    public weak var delegate: PFPickerViewDelegate? {
        didSet {
            var tabHeight: CGFloat = 0
            if let delegate = delegate {
                for section in 0..<(delegate.numberOfSections?() ?? 1) {
                    var selectedSection: [Bool] = []
                    
                    // 计算tableview高度
                    let headerHeight = delegate.pickerView?(self, heightForHeaderInSection: section) ?? 0
                    tabHeight += headerHeight
                    
                    let footerHeight = delegate.pickerView?(self, heightForFooterInSection: section) ?? 0
                    tabHeight += footerHeight
                    
                    for row in 0..<delegate.numberOfRows(inSection: section) {
                        
                        let indexPath = IndexPath(row: row, section: section)
                        
                        let rowHeight = delegate.pickerView?(self, heightForRowAt: indexPath) ?? Constants.defaultRowHeight
                        tabHeight += rowHeight
                        
                        selectedSection.append(false)
                    }
                    
                    selectedStatus.append(selectedSection)
                }
            }
            whiteBgView.bounds.size.height = min(maxHeight, Constants.topHeight + tabHeight)
        }
    }
    
    public var maxHeight: CGFloat = 450 {
        didSet {
            whiteBgView.bounds.size.height = min(maxHeight, whiteBgView.bounds.size.height)
        }
    }
    
    public private(set) var titleLab: UILabel!
    public private(set) var tableView: UITableView!
    
    private var whiteBgView: UIView!
    
    var title: String?
    var tableVieStyle: UITableView.Style = .plain
    var selectionStyle: SelectionStyle = .single
    var cancelHandler: PFPickerViewCancelEventHandler?
    var conformHandler: PFPickerViewConfirmEventHandler?
    
    var cellClass: PFPickerCell.Type?
    var identifier: String?
    
    private var selectedStatus: [[Bool]] = []
    
    public required init(title: String?,
                         tableViewStyle: UITableView.Style = .plain,
                         selectionStyle: PFPickerView.SelectionStyle,
                         cancelHandler: PFPickerViewCancelEventHandler?,
                         conformHandler: PFPickerViewConfirmEventHandler?) {
        super.init(frame: UIScreen.main.bounds)
        self.title = title
        self.tableVieStyle = tableViewStyle
        self.selectionStyle = selectionStyle
        self.cancelHandler = cancelHandler
        self.conformHandler = conformHandler
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

extension PFPickerView: UITableViewDataSource, UITableViewDelegate, PFPickerCellDelegate {

    public func numberOfSections(in tableView: UITableView) -> Int { delegate?.numberOfSections?() ?? 1 }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { delegate?.numberOfRows(inSection: section) ?? 0 }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: PFPickerCell.reuseIdentity()) as? PFPickerCell ?? PFPickerCell()
        
        if let cellClass = cellClass, let identifier = identifier {
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? PFPickerCell ?? PFPickerCell()
        }
        cell.delegate = self
        cell.indexPath = indexPath
        cell.selectBtn.isSelected = selectedStatus[indexPath.section][indexPath.row]
        delegate?.pickerView(self, cell: cell, at: indexPath)
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? PFPickerCell {
            cell.selectBtn.isSelected = !cell.selectBtn.isSelected
            
            if selectionStyle == .single {
                selectedStatus.removeAll()
                for section in 0..<(delegate!.numberOfSections?() ?? 1) {
                    var selectedSection: [Bool] = []
                    for row in 0..<delegate!.numberOfRows(inSection: section) {
                        selectedSection.append(false)
                    }
                    selectedStatus.append(selectedSection)
                }
            }
            selectedStatus[indexPath.section][indexPath.row] = cell.selectBtn.isSelected

            tableView.reloadData()
            delegate?.pickerView?(self, didSelectRowAt: indexPath, select: cell)
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        delegate?.pickerView?(self, heightForRowAt: indexPath) ?? Constants.defaultRowHeight
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        delegate?.pickerView?(self, viewForHeaderInSection: section)
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        delegate?.pickerView?(self, heightForHeaderInSection: section) ?? 0
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        delegate?.pickerView?(self, viewForFooterInSection: section)
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        delegate?.pickerView?(self, heightForFooterInSection: section) ?? 0.01
    }
    
    public func selected(cell: PFPickerCell) {
        tableView(tableView, didSelectRowAt: cell.indexPath)
    }
}

public extension PFPickerView {
    func show(animated: Bool) {
        let window = UIApplication.shared.windows.first

        window?.addSubview(self)
        window?.bringSubviewToFront(self)
        whiteBgView.layoutIfNeeded()
        if animated {
            UIView.animate(withDuration: 0.3) {
                self.backgroundColor = SystemColor.mask
                self.whiteBgView.frame.origin.y = self.bounds.size.height - min(self.maxHeight, self.whiteBgView.bounds.size.height)
            }
        } else {
            whiteBgView.frame.origin.y = self.bounds.size.height - min(self.maxHeight, self.whiteBgView.bounds.size.height) 
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
        cancelHandler?()
        hide(animated: true)
    }
    
    @objc
    func confirmEvent() {
        
        var selectedIndexPaths: [IndexPath] = []
        
        for section in 0..<selectedStatus.count {
            let sectionStatuses = selectedStatus[section]
            for row in 0..<sectionStatuses.count {
                let rowStatuses = sectionStatuses[row]
                if rowStatuses == true {
                    let indexPath = IndexPath(row: row, section: section)
                    selectedIndexPaths.append(indexPath)
                }
            }
        }
        conformHandler?(selectedIndexPaths)
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
        titleLab.font = .pingfang(style: .medium, size: 15)
        if selectionStyle == .single {
            titleLab.text = self.title
        } else {
            if let title = title {
                let attText = NSMutableAttributedString(string: "\(title)(可多选)")
                let titleRange =  NSRange(attText.string.range(of: title)!, in: attText.string)
                let multipleRange = NSRange(attText.string.range(of: "(可多选)")!, in: attText.string)
                attText.addAttributes([NSAttributedString.Key.font: UIFont.pingfang(style: .medium, size: 15)], range: titleRange)
                attText.addAttributes([NSAttributedString.Key.font: UIFont.pingfang(style: .regular, size: 14)], range: multipleRange)
                titleLab.attributedText = attText
            }
        }
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
        
        tableView = UITableView(frame: .zero, style: tableVieStyle)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: 0.01))
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
    
    static let topHeight: CGFloat = commonMargin * 2 + 15
    
    static let defaultRowHeight: CGFloat = 50
}
