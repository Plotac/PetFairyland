//
//  PFBaseViewController.swift
//  PetFairyland
//
//  Created by Ja on 2023/7/27.
//

import UIKit

open class PFBaseViewController: UIViewController {
    
    open override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}
