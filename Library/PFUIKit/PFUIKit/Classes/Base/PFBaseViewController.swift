//
//  PFBaseViewController.swift
//  PetFairyland
//
//  Created by Ja on 2023/7/27.
//

@_exported import PFUtility
import UIKit
import MJRefresh

open class PFBaseViewController: UIViewController {
    
    public typealias PFRefreshHeaderCompletion = () -> Void
    public typealias PFRefreshFooterCompletion = () -> Void
    
    open lazy var refreshHeader: MJRefreshStateHeader = {
        return MJRefreshStateHeader { [weak self] in
            self?.refreshHeaderEvent?()
        }
    }()
    open var refreshHeaderEvent: PFRefreshHeaderCompletion?
    
    open lazy var refreshFooter: MJRefreshAutoStateFooter = {
        return MJRefreshAutoStateFooter { [weak self] in
            self?.refreshFooterEvent?()
        }
    }()
    open var refreshFooterEvent: PFRefreshFooterCompletion?
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = SystemColor.viewBackgroundColor
    }
    
    deinit {
        print("\(Self.self.description()) ---------- deinit")
    }
}
