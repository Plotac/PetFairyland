//
//  ProductManageListController.swift
//  PetFairyland
//
//  Created by Ja on 2023/10/9.
//

import Foundation

class ProductManageListController: PFBaseSegmentListController {
    
    var viewModel = ProductManageListViewModel()
    
    var status: ProductManageModel.Status = .online
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.reloadTabData(status: status)
    }
    
    required init(status: ProductManageModel.Status) {
        super.init(nibName: nil, bundle: nil)
        self.status = status
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func listView() -> UIView { view }
    
    override func listScrollView() -> UIScrollView {
        viewModel.manageTableView
    }
}

extension ProductManageListController {
    func setupUI() {
        view.addSubview(viewModel.manageTableView)
        viewModel.manageTableView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(kBottomSafeMargin - ProductManageCell().lineSpacing)
        }
    }
}
