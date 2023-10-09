//
//  ProductManageListController.swift
//  PetFairyland
//
//  Created by Ja on 2023/10/9.
//

import Foundation

class ProductManageListController: PFBaseSegmentListController {
    
    var viewModel: ProductManageListViewModel!
    
    var models: [ProductManageModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    required init(models: [ProductManageModel]) {
        super.init(nibName: nil, bundle: nil)
        viewModel = ProductManageListViewModel(models: models)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
