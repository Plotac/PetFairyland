//
//  PFBaseSegmentController.swift
//  PFUIKit
//
//  Created by Ja on 2023/10/9.
//

import UIKit
import JXPagingView
import JXSegmentedView

public protocol PFBaseSegmentDataSource: NSObjectProtocol {
    func segmentTitles() -> [String]
    func segmentPagingControllers() -> [JXPagingViewListViewDelegate & PFBaseViewController]
}

extension JXPagingListContainerView: JXSegmentedViewListContainer {}
 
open class PFBaseSegmentController: PFBaseViewController, JXSegmentedViewDelegate {
    
    public weak var dataSource: PFBaseSegmentDataSource?
    
    public var pagingView: JXPagingListRefreshView!
    
    public var segmentView: JXSegmentedView!
    
    public private(set) var segmentTitles: [String]?
    
    private let segmentDataSource: JXSegmentedTitleAttributeDataSource = JXSegmentedTitleAttributeDataSource()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentTitles = dataSource?.segmentTitles()

        setupUI()
    }
}

extension PFBaseSegmentController: JXPagingViewDelegate {
    public func pagingView(_ pagingView: JXPagingView, initListAtIndex index: Int) -> JXPagingViewListViewDelegate {
        assert(dataSource?.segmentPagingControllers().isEmpty == false)
        return dataSource?.segmentPagingControllers()[index] ?? PFBaseSegmentListController()
    }
    
    public func tableHeaderViewHeight(in pagingView: JXPagingView) -> Int { 0 }
    
    public func tableHeaderView(in pagingView: JXPagingView) -> UIView { UIView() }
    
    public func heightForPinSectionHeader(in pagingView: JXPagingView) -> Int { 0 }
    
    public func viewForPinSectionHeader(in pagingView: JXPagingView) -> UIView { segmentView }
    
    public func numberOfLists(in pagingView: JXPagingView) -> Int { segmentTitles?.count ?? 0 }
}

extension PFBaseSegmentController {
    
    func setupUI() {
        segmentView = JXSegmentedView()
        segmentView.dataSource = segmentDataSource
        segmentView.delegate = self
        view.addSubview(segmentView)
        segmentView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(12)
            make.height.equalTo(40)
        }
        
        let indicator = JXSegmentedIndicatorLineView()
        indicator.indicatorColor = SystemColor.main
        indicator.indicatorWidth = 30
        indicator.indicatorHeight = 3
        indicator.layer.cornerRadius = 1.5
        indicator.layer.masksToBounds = true
        segmentView.indicators = [indicator]
        
        pagingView = JXPagingListRefreshView(delegate: self, listContainerType: .collectionView)
        pagingView.backgroundColor = .clear
        pagingView.mainTableView.backgroundColor = .clear
        if #available(iOS 15.0, *) {
            pagingView.mainTableView.sectionHeaderTopPadding = 0
        }
        view.addSubview(pagingView)
        pagingView.snp.makeConstraints { make in
            make.top.equalTo(segmentView.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(kBottomSafeMargin)
        }
        
        segmentView.listContainer = pagingView.listContainerView
        
        var attriTexts: [NSAttributedString] = []
        
        if let titles = segmentTitles {
            for title in titles {
                let attriText = NSMutableAttributedString(string: title)
                
                let range: NSRange = NSRange(attriText.string.range(of: title)!, in: attriText.string)
                
                attriText.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.black,
                                         NSAttributedString.Key.font: UIFont.pingfang(style: .medium, size: 14)], range: range)
                if let copyAttriText = attriText.copy() as? NSAttributedString {
                    attriTexts.append(copyAttriText)
                }
            }
        }
        
        segmentDataSource.attributedTitles = attriTexts
        segmentDataSource.selectedAttributedTitles = attriTexts
    }
}
