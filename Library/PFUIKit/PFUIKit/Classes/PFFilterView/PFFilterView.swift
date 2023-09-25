//
//  PFFilterView.swift
//  PFUIKit
//
//  Created by Ja on 2023/9/21.
//

import UIKit

public class PFFilterView: UIView {
    
    public var options: [PFFilterOption] = []
    
    internal var tableView: UITableView!
    
    public required init(frame: CGRect, options: [PFFilterOption]) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PFFilterView {
    func setupUI() {
//        tableView = UITableView(frame: .zero, style: .plain)
//        tableView = UITableView(frame: .zero, style: .plain)
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.backgroundColor = .clear
//        tableView.separatorStyle = .none
//        tableView.showsVerticalScrollIndicator = false
//        if #available(iOS 15.0, *) {
//            tableView.sectionHeaderTopPadding = 0
//        }
//        tableView.register(HomeFunctionalZoneCell.self, forCellReuseIdentifier: HomeFunctionalZoneCell.reuseIdentity())
    }
}
