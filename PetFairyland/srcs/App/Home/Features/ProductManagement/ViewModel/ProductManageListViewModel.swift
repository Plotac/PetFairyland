//
//  ProductManageListViewModel.swift
//  PetFairyland
//
//  Created by Ja on 2023/10/9.
//

import Foundation

class ProductManageListViewModel: NSObject {
    
    var manageTableView: UITableView!
    
    var productModels: [ProductManageModel] = []
    
    var onlineModels: [ProductManageModel] {
        productModels.filter { $0.status == .online }
    }
    
    var offlineModels: [ProductManageModel] {
        productModels.filter { $0.status == .offline }
    }
    
    var currentSelectedStatus: ProductManageModel.Status = .online
    
    override init() {
        super.init()
        buildUI()
        productModels = generateTestModels()
    }
    
    func generateTestModels() -> [ProductManageModel] {
        var models: [ProductManageModel] = []
        
        let productNames = ["猫咪洗护套餐", "猫咪绝育套餐", "猫咪疫苗三联", "狗狗洗护套餐", "狗狗洁牙套餐", "猫咪洗澡服务", "猫咪体检"]
        productNames.forEach { name in
            let model = ProductManageModel()
            model.name = name
            model.price = min(100, CGFloat(arc4random() % 500))
            model.membershipPrice = min(80, CGFloat(arc4random() % 500))
            model.serviceTime = 0.5
            model.salesVolume = Int(arc4random() % 1000)
            model.status = ProductManageModel.Status.init(rawValue: Int(arc4random() % 2)) ?? .online
            models.append(model)
        }
        
        return models
    }
    
    func reloadTabData(status: ProductManageModel.Status) {
        currentSelectedStatus = status
        manageTableView.reloadData()
    }
}

extension ProductManageListViewModel: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentSelectedStatus == .online ? onlineModels.count : offlineModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductManageCell.reuseIdentity(), for: indexPath) as? ProductManageCell ?? ProductManageCell()
        cell.selectionStyle = .none
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.model = currentSelectedStatus == .online ? onlineModels[indexPath.row] : offlineModels[indexPath.row]
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
