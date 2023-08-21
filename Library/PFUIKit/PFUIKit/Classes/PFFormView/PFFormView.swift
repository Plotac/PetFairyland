//
//  PFFormView.swift
//  PFUIKit
//
//  Created by Ja on 2023/8/1.
//

import UIKit

open class PFFormView: UIView {
    
    public internal(set) var tableView: UITableView!
    
    public internal(set) var models: [PFFormModel] = []
    
    public required init(frame: CGRect, models: [PFFormModel]) {
        super.init(frame: frame)
        self.models = models
        setupUI()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PFFormView: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { models.count }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PFFormCell.reuseIdentity(), for: indexPath) as? PFFormCell ?? PFFormCell()
        cell.model = models[indexPath.row]
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = models[indexPath.row]
        return model.rowHeight
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
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
 
