//
//  ProductManageController.swift
//  PetFairyland
//
//  Created by Ja on 2023/10/9.
//

import Foundation
import JXSegmentedView
import JXPagingView

class ProductManageController: PFBaseSegmentController {
    
    override init() {
        super.init()
        dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "商品管理"
        
        setupUI()
    }
}

extension ProductManageController {
    @objc
    func addNewProduct() {
        
    }
}

extension ProductManageController: PFBaseSegmentDataSource {
    func segmentPagingController(at index: Int) -> JXPagingViewListViewDelegate {
        if index == 0 {
            return ProductManageListController(status: .online)
        }
        return ProductManageListController(status: .offline)
    }
    
    func segmentTitles() -> [String] {
        return ["上线中", "已下线"]
    }
}

extension ProductManageController {
    func setupUI() {
        let barBtn = UIButton(type: .custom)
        barBtn.setImage(UIImage(named: "nav_add"), for: .normal)
        barBtn.addTarget(self, action: #selector(addNewProduct), for: .touchUpInside)
        let opBarItem = UIBarButtonItem(customView: barBtn)
        navigationItem.rightBarButtonItem = opBarItem
    }
}
