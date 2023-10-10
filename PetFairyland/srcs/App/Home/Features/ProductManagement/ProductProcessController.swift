//
//  ProductProcessController.swift
//  PetFairyland
//
//  Created by Ja on 2023/10/10.
//

import Foundation

class ProductProcessController: PFBaseViewController {
    
    enum ProcessType {
    case add, edit
    }
    
    var type: ProcessType = .add
    
    required init(type: ProcessType) {
        super.init(nibName: nil, bundle: nil)
        self.type = type
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension ProductProcessController {
    func setupUI() {
        title = type == .add ? "新增商品" : "编辑商品"
    }
}
