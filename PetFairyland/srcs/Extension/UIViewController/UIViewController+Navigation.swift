//
//  UIViewController+Navigation.swift
//  PetFairyland
//
//  Created by Ja on 2023/7/25.
//

import UIKit

extension UIViewController {
    func setupBackBtn() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_backicon_black"), style: .done, target: self, action: #selector(originalBackAction))
    }
    
    @objc func originalBackAction() {
        navigationController?.popViewController(animated: true)
    }
}
