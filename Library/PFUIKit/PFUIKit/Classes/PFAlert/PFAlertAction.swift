//
//  PFAlertAction.swift
//  PFUIKit
//
//  Created by Ja on 2023/9/15.
//

import Foundation

public class PFAlertAction: NSObject {

    public typealias PFAlertActionHandler = (PFAlertAction) -> Void

    public enum PFAlertActionStyle {
        case confirm, cancel
        case other(cornerRadius: CGFloat,
                   backgroundColor: UIColor,
                   backgroundGradientColors: (startColor: UIColor?, endColor: UIColor?)?,
                   textColor: UIColor,
                   font: UIFont)
    }

    public private(set) var style: PFAlertActionStyle = .confirm

    public private(set) var title: String?

    public private(set) var size: CGSize = .zero

    private(set) var handler: PFAlertActionHandler?

    public required init(title: String?,
                         style: PFAlertActionStyle,
                         size: CGSize = .zero,
                         handler: PFAlertActionHandler? = nil) {
        super.init()
        self.title = title
        self.style = style
        self.handler = handler
        self.size = size
    }

    struct UIConstants {

        struct Common {
            static let cornerRadius: CGFloat = 0
        }
        struct Confirm {
            static let backgroundColor: UIColor = .white
            static let backgroundGradientColors: (startColor: UIColor?, endColor: UIColor?)? = nil
            static let textColor: UIColor = UIColor(hexString: "#FABA00")
            static let font: UIFont = UIFont.pingfang(style: .medium, size: 17)
        }

        struct Cancel {
            static let backgroundColor: UIColor = .white
            static let backgroundGradientColors: (startColor: UIColor?, endColor: UIColor?)? = nil
            static let textColor: UIColor = UIColor(hexString: "#000000")
            static let font: UIFont = UIFont.pingfang(style: .medium, size: 17)
        }
    }
}
