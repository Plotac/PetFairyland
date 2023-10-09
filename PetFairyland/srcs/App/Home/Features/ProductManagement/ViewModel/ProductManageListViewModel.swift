//
//  ProductManageListViewModel.swift
//  PetFairyland
//
//  Created by Ja on 2023/10/9.
//

import Foundation

class ProductManageListViewModel: NSObject {
    
    var manageTableView: UITableView!
    
    var models: [ProductManageModel] = []
    
    required init(models: [ProductManageModel]) {
        super.init()
        self.models = models
        buildUI()
    }
}

extension ProductManageListViewModel: ProductManageCellDelegate {
    func execute(operation: ProductManageCell.Operation, model: ProductManageModel) {
        print("\(model.name)-------\(operation.rawValue)")
    }
}
 
extension ProductManageListViewModel: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { models.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductManageCell.reuseIdentity(), for: indexPath) as? ProductManageCell ?? ProductManageCell()
        cell.selectionStyle = .none
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.delegate = self
        cell.model = models[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat { 10 }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 10))
    }
}

// MARK: - Private
extension ProductManageListViewModel {
    
    func buildUI() {
        manageTableView = UITableView(frame: .zero, style: .plain)
        manageTableView.delegate = self
        manageTableView.dataSource = self
        manageTableView.backgroundColor = .clear
        manageTableView.rowHeight = 160 + ProductManageCell().lineSpacing
        manageTableView.separatorStyle = .none
        manageTableView.showsVerticalScrollIndicator = false
        manageTableView.tableFooterView = UIView()
        if #available(iOS 15.0, *) {
            manageTableView.sectionHeaderTopPadding = 0
        }
        manageTableView.register(ProductManageCell.self, forCellReuseIdentifier: ProductManageCell.reuseIdentity())
    }
}
