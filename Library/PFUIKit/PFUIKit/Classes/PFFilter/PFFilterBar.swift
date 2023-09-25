//
//  PFFilterBar.swift
//  PFUIKit
//
//  Created by Ja on 2023/9/25.
//

import Foundation

public protocol PFFilterBarDelegate: NSObjectProtocol {
    func filterBar(_ filterBar: PFFilterBar, didSelected filter: PFFilter, selectedOption option: PFFilterOption)
}

extension PFFilterBarDelegate {
    func filterBar(_ filterBar: PFFilterBar, didSelected filter: PFFilter, selectedOption option: PFFilterOption) {}
}

public class PFFilterBar: UIView {
    
    public enum FilterAlignment {
        case center, left, right
    }
    
    public weak var delegate: PFFilterBarDelegate?
    
    public private(set) var filters: [PFFilter] = []
    
    public var filterAlignment: FilterAlignment = .center {
        didSet {
            setNeedsLayout()
        }
    }
    
    public var filterWidth: CGFloat = 100 {
        didSet {
            setNeedsLayout()
        }
    }
    
    /// PFFilterBar左右两侧间距
    public var insetMargin: CGFloat = 10 {
        didSet {
            setNeedsLayout()
        }
    }
    
    /// 过滤器之间的间距，仅当filterAlignment  != .center时有效
    public var padding: CGFloat = 10 {
        didSet {
            setNeedsLayout()
        }
    }
    
    public required init(frame: CGRect, filters: [PFFilter]) {
        super.init(frame: frame)
        self.filters = filters
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        var padding = filterAlignment == .center ? (self.bounds.size.width - CGFloat(filters.count) * filterWidth - insetMargin * 2) / CGFloat(filters.count - 1) : self.padding
        
        if filterAlignment == .right {
            filters = filters.reversed()
        }
        for (index, view) in filters.enumerated() {
            view.snp.remakeConstraints { make in
                if filterAlignment == .center || filterAlignment == .left {
                    make.left.equalToSuperview().offset(insetMargin + CGFloat(index) * (filterWidth + padding))
                } else {
                    make.right.equalToSuperview().inset(insetMargin + CGFloat(index) * (filterWidth + padding))
                }
                make.centerY.equalToSuperview()
                make.size.equalTo(CGSize(width: filterWidth, height: self.bounds.size.height))
            }
        }

    }
}

extension PFFilterBar: PFFilterDelegate {
    public func filter(_ filter: PFFilter, didSelected option: PFFilterOption) {
        delegate?.filterBar(self, didSelected: filter, selectedOption: option)
    }
    
    public func filterMainButtonTouched(_ filter: PFFilter) {
        filters.forEach { f in
            if f != filter {
                f.processTableViewDisplay(show: false)
            }
        }
    }
}

extension PFFilterBar {
    func setupUI() {
        backgroundColor = .white
        filters.forEach { view in
            view.delegate = self
            addSubview(view)
        }
    }
}
