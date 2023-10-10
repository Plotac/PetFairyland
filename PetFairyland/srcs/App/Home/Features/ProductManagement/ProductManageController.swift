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
    
    var viewModel = ProductManageViewModel()
    
    private lazy var onlineController: ProductManageListController = {
        return ProductManageListController(models: viewModel.onlineModels)
    }()
    
    private lazy var offlineController: ProductManageListController = {
        return ProductManageListController(models: viewModel.offlineModels)
    }()
    
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
        navigationController?.pushViewController(ProductProcessController(type: .add), animated: true)
    }
}

extension ProductManageController: PFBaseSegmentDataSource {
    func segmentPagingControllers() -> [PFBaseViewController & JXPagingViewListViewDelegate] {
        return [onlineController, offlineController]
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
