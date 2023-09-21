//
//  PFFiltrationView.swift
//  PFUIKit
//
//  Created by Ja on 2023/9/21.
//

import UIKit

public class PFFiltrationView: UIView {
    
    public var options: [PFFiltrationOption] = []
    
    internal var tableView: UITableView!
    
    public required init(frame: CGRect, options: [PFFiltrationOption]) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PFFiltrationView {
    func setupUI() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        tableView.register(HomeFunctionalZoneCell.self, forCellReuseIdentifier: HomeFunctionalZoneCell.reuseIdentity())
    }
}
