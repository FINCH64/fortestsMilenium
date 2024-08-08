//
//  SmallButton Constants.swift
//  fortests
//
//  Created by Alexey on 8.08.24.
//

import UIKit

extension SmallButtonPrimary {

    enum Constants {

        enum Colors {
            static let defaultStateColor : UIColor = UIColor(named: "Yellow default") ?? .yellow
            static let clickedStateColor : UIColor = UIColor(named: "Yellow clicked") ?? .orange
            static let defaultTextColor: UIColor = UIColor(named: "Text main") ?? .black
        }

        enum UILabel {
            static let font: UIFont = UIFont(name: "SF Pro Text", size: 13) ?? .systemFont(ofSize: 13)
            static let titleText: String = "Label-3"
        }

        enum UIButton {
            static let cornerRadius: CGFloat = 14
        }
    }

    enum States {
        case `default`
        case clicked
    }
}

