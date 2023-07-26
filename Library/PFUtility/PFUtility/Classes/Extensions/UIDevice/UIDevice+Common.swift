//
//  UIDevice+Common.swift
//  PetFairyland
//
//  Created by Ja on 2023/7/25.
//

import UIKit

public extension UIDevice {
    static func isiPad() -> Bool {
        return UIDevice.current.model == "iPad"
    }
}
