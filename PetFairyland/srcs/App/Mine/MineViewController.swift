//
//  MineViewController.swift
//  PetFairyland
//
//  Created by Ja on 2023/9/21.
//

import UIKit
import FDFullscreenPopGesture

class MineViewController: PFBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我的"
        
        setupUI()
    }
}

private extension MineViewController {
    @objc
    func changeSwitchValue(sw: UISwitch) {
        PFAccount.shared.isLogin = sw.isOn
        view.setNeedsUpdateConstraints()
    }
}

extension MineViewController {
    func setupUI() {
        fd_prefersNavigationBarHidden = true
        
        let loginSwitch = UISwitch(frame: .zero)
        loginSwitch.sizeToFit()
        loginSwitch.isOn = false
        loginSwitch.addTarget(self, action: #selector(changeSwitchValue), for: .valueChanged)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: loginSwitch)
    }
}
