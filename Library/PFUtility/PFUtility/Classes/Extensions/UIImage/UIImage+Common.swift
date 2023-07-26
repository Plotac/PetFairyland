//
//  UIImage+Common.swift
//  PetFairyland
//
//  Created by Ja on 2023/7/25.
//

import Foundation
import UIKit

public extension UIImage {
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: CGPoint.zero, size: size)
        UIGraphicsBeginImageContext(size)
        defer {
            UIGraphicsEndImageContext()
        }
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(rect)

            if let cgImage = context.makeImage() {
                self.init(cgImage: cgImage)
                return
            }
        }
        return nil
    }

    convenience init?(colors: [UIColor], size: CGSize) {
        let cgColors = colors.map { color -> CGColor in
            color.cgColor
        }

        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        defer  {
            UIGraphicsEndImageContext()
        }

        if let context = UIGraphicsGetCurrentContext() {
            guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                    colors: cgColors as CFArray, locations: nil) else {
                return nil
            }

            context.drawLinearGradient(gradient,
                    start: CGPoint.zero,
                    end: CGPoint(x: size.width, y: size.height),
                    options: [.drawsBeforeStartLocation,
                              .drawsAfterEndLocation])

            if let cgImage = context.makeImage() {
                self.init(cgImage: cgImage)
                return
            }
        }

        return nil
    }
}
