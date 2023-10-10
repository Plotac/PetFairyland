//
//  PFFilter.swift
//  PFUIKit
//
//  Created by Ja on 2023/9/21.
//

import UIKit

public protocol PFFilterDelegate: NSObjectProtocol {
    func filterTouched(_ filter: PFFilter)
    func filter(_ filter: PFFilter, didSelected option: PFFilterOption)
}

extension PFFilterDelegate {
    func filterTouched(_ filter: PFFilter) {}
    func filter(_ filter: PFFilter, didSelected option: PFFilterOption) {}
}

public class PFFilter: UIView {
    
    public weak var delegate: PFFilterDelegate?
    
    public var options: [PFFilterOption] = []
    
    public var selectedTextColor: UIColor = SystemColor.main
    
    public var normalTextColor: UIColor = UIColor(hexString: "#808080")
    
    var mainBtn: UIButton!
    
    private var tableView: UITableView!
    
    private var maskBgView: UIView!
    
    public required init(frame: CGRect, options: [PFFilterOption]) {
        super.init(frame: frame)
        self.options = options
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if let title = mainBtn.titleLabel?.text {
            // 左右最小边距
            let minMargin: CGFloat = 10
            // titleLabel和imageView中间的距离
            let space: CGFloat = 5
            // imageView的宽高
            let arrowWH: CGFloat = 16
            
            var titleWidth = title.strWidth(font: .pingfang(style: .regular, size: 14), size: CGSize(width: CGFLOAT_MAX, height: mainBtn.bounds.size.height))
            var startX: CGFloat = (mainBtn.bounds.size.width - arrowWH - space - titleWidth) / 2
            
            if startX < minMargin {
                startX = minMargin
                titleWidth = mainBtn.bounds.size.width - arrowWH - space - minMargin * 2
            }
            
            mainBtn.titleLabel?.snp.remakeConstraints({ make in
                make.centerY.equalToSuperview()
                make.left.equalToSuperview().offset(startX)
                make.right.equalTo(mainBtn.imageView!.snp.left).offset(-space)
                make.size.equalTo(CGSize(width: titleWidth, height: mainBtn.bounds.size.height))
            })

            mainBtn.imageView?.snp.remakeConstraints({ make in
                make.centerY.equalTo(mainBtn.titleLabel!)
                make.left.equalTo(mainBtn.titleLabel!.snp.left).offset(titleWidth + space)
                make.size.equalTo(arrowWH)
            })
        }

    }
}

extension PFFilter {
    @objc
    func open(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        processTableViewDisplay(show: sender.isSelected)
        
        delegate?.filterTouched(self)
    }
    
    @objc
    func tap() {
        processTableViewDisplay(show: false)
    }
}

extension PFFilter: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { options.count }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PFFilterCell.reuseIdentity(), for: indexPath) as? PFFilterCell ?? PFFilterCell()
        
        cell.normalTextColor = normalTextColor
        cell.selectedTextColor = selectedTextColor
        cell.separatorLine.isHidden = indexPath.row == options.count - 1
        
        cell.option = options[indexPath.row]
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let option = options[indexPath.row]
        delegate?.filter(self, didSelected: option)
        
        mainBtn.setTitle(option.title, for: .normal)
        
        processTableViewDisplay(show: false)
    }
}

extension PFFilter {
    func setupUI() {
        backgroundColor = .white
        
        let defaultSelectedOption = options.first { $0.selected == true }
        
        mainBtn = UIButton(type: .custom)
        
        mainBtn.titleLabel?.font = .pingfang(style: .regular, size: 14)
        mainBtn.titleLabel?.lineBreakMode = .byTruncatingTail
        let title = defaultSelectedOption?.title ?? "-"
        mainBtn.setTitle(title, for: .normal)
        mainBtn.setTitleColor(SystemColor.main, for: .selected)
        mainBtn.setTitleColor(UIColor(hexString: "#808080"), for: .normal)
        mainBtn.setImage(UIImage(named: "filter_arrow_unselected"), for: .normal)
        mainBtn.setImage(UIImage(named: "filter_arrow_selected"), for: .selected)
        mainBtn.addTarget(self, action: #selector(open(sender:)), for: .touchUpInside)
        addSubview(mainBtn)
        mainBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.rowHeight = 50
        tableView.showsVerticalScrollIndicator = false
        tableView.layer.cornerRadius = 8
        tableView.layer.masksToBounds = true
        tableView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        tableView.register(PFFilterCell.self, forCellReuseIdentifier: PFFilterCell.reuseIdentity())
        
        maskBgView = UIView()
        maskBgView.backgroundColor = SystemColor.mask
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tap))
        maskBgView.addGestureRecognizer(tap)
    }
    
    
    func processTableViewDisplay(show: Bool) {
        if show {
            if let window = UIApplication.shared.windows.first {
                window.addSubview(tableView)
                tableView.snp.makeConstraints { make in
                    make.top.equalTo(self.snp.bottom)
                    make.left.right.equalToSuperview()
                    make.height.equalTo(options.count * 50)
                }
                
                window.addSubview(maskBgView)
                maskBgView.snp.makeConstraints { make in
                    make.top.equalTo(tableView)
                    make.left.right.bottom.equalToSuperview()
                }
                
                window.bringSubviewToFront(tableView)
            }
        } else {
            mainBtn.isSelected = false
            tableView.removeFromSuperview()
            maskBgView.removeFromSuperview()
        }
        
        setNeedsLayout()
    }
}
