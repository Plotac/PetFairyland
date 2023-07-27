//
//  UIViewController+Navigation.swift
//  PetFairyland
//
//  Created by Ja on 2023/7/25.
//

import UIKit

public extension UIViewController {
    func setupBackBtn(backImageStr: String = "nav_backicon_white") {
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: backImageStr), for: .normal)
        backBtn.addTarget(self, action: #selector(originalBackAction), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
    }
    
    @objc func originalBackAction() {
        navigationController?.popViewController(animated: true)
    }
    
    func resetNavigationBarAppearance(color: UIColor = SystemColor.main) {
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = color
        appearance.backgroundEffect = nil
        appearance.shadowColor = nil
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 18)]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
