//
//  PFFilterBar.swift
//  PFUIKit
//
//  Created by Ja on 2023/9/25.
//

import Foundation

public class PFFilterBar: UIView {
    
    public var views: [PFFilterView] = []
    
    public required init(frame: CGRect, containerViews: [PFFilterView]) {
        super.init(frame: frame)
        views = containerViews
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PFFilterBar {
    func setupUI() {
        
    }
}
