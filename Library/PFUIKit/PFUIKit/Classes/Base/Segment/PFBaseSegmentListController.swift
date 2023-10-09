//
//  PFBaseSegmentListController.swift
//  PFUIKit
//
//  Created by Ja on 2023/10/9.
//

import UIKit
import JXPagingView

open class PFBaseSegmentListController: PFBaseViewController, JXPagingViewListViewDelegate {
    open func listView() -> UIView {
        self.view
    }
    
    open func listScrollView() -> UIScrollView {
        UIScrollView()
    }
    
    open func listViewDidScrollCallback(callback: @escaping (UIScrollView) -> ()) {}
}
