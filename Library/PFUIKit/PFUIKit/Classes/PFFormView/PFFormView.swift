//
//  PFFormView.swift
//  PFUIKit
//
//  Created by Ja on 2023/8/1.
//

import UIKit

open class PFFormView: UIView {
    
    public internal(set) var tableView: UITableView!
    
    public internal(set) var sectionModels: [PFFormSectionModel] = []
    
    public required init(frame: CGRect, sectionModels: [PFFormSectionModel]) {
        super.init(frame: frame)
        self.sectionModels = sectionModels
        setupUI()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PFFormView: UITableViewDataSource, UITableViewDelegate {
    
    public func numberOfSections(in tableView: UITableView) -> Int { sectionModels.count }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { sectionModels[section].formModels?.count ?? 0 }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PFFormCell.reuseIdentity(), for: indexPath) as? PFFormCell ?? PFFormCell()
        cell.model = sectionModels[indexPath.section].formModels?[indexPath.row]
        return cell
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rowCount = tableView.numberOfRows(inSection: indexPath.section)
        let sectionModel = sectionModels[indexPath.section]

        // 处理圆角
        if rowCount == 1 {
            let corners: UIRectCorner = sectionModel.showHeader ? [.bottomLeft, .bottomRight] : .allCorners
            setCornerRadius(for: cell, byRoundingCorners: corners, radius: 10)
        } else {
            var corners: UIRectCorner? = nil
            if indexPath.row == 0 {
                corners = sectionModel.showHeader ? nil : [.topLeft, .topRight]
            } else if indexPath.row == rowCount - 1 {
                corners = [.bottomLeft, .bottomRight]
            }
            if let corners = corners {
                setCornerRadius(for: cell, byRoundingCorners: corners, radius: 10)
            }
        }
        
        func setCornerRadius(for cell: UITableViewCell,
                             byRoundingCorners corners: UIRectCorner,
                             radius: CGFloat) {
            let bezierPath = UIBezierPath(roundedRect: cell.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = bezierPath.cgPath
            cell.layer.mask = shapeLayer
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sectionModels[indexPath.section].formModels?[indexPath.row].rowHeight ?? 0
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: PFFormHeaderView.reuseIdentity()) as? PFFormHeaderView ?? PFFormHeaderView()
        header.titleLab.text = sectionModels[section].title
        return header
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionModel = sectionModels[section]
        return sectionModel.showHeader ? sectionModel.headerHeight : 0
    }
}

private extension PFFormView {
    func setupUI() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(PFFormCell.self, forCellReuseIdentifier: PFFormCell.reuseIdentity())
        tableView.register(PFFormHeaderView.self, forHeaderFooterViewReuseIdentifier: PFFormHeaderView.reuseIdentity())
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 10
        }
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
 
