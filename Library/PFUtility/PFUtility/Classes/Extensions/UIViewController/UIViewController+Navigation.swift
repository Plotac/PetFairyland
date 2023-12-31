//
//  UIViewController+Navigation.swift
//  PetFairyland
//
//  Created by Ja on 2023/7/25.
//

import UIKit

public extension UIViewController {
    func setupBackBtn(backImageStr: String = "nav_backicon_black") {
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: backImageStr), for: .normal)
        backBtn.addTarget(self, action: #selector(originalBackAction), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
    }
    
    @objc func originalBackAction() {
        navigationController?.popViewController(animated: true)
    }
    
    func resetNavigationBarAppearance(color: UIColor? = nil, gradientColors: (startColor: UIColor, endColor: UIColor)? = nil, resetCurrentNav: Bool = false) {
        
        let appearance = UINavigationBarAppearance()
        if let color = color {
            appearance.backgroundColor = color
            appearance.backgroundImage = nil
            appearance.shadowImage = nil
        } else {
            var gColors = (SystemColor.nav.startColor, SystemColor.nav.endColor)
            if let gradientColors = gradientColors {
                gColors = gradientColors
            }
            appearance.backgroundImage = UIImage(gradientColors: gColors, size: CGSize(width: Screen.width, height: kTopHeight))
            appearance.shadowImage = UIImage(color: SystemColor.nav.endColor)
        }
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont.boldSystemFont(ofSize: 18)]
        
        if resetCurrentNav {
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        } else {
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}
