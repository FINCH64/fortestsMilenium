//
//  SecondaryButton Constants.swift
//  fortests
//
//  Created by Alexey on 7.08.24.
//

import UIKit

extension SecondaryButton {

    enum Constants {

        enum Colors {
            static let defaultStateColor : UIColor = UIColor(named: "Gray secondary default") ?? .lightGray
            static let clickedStateColor : UIColor = UIColor(named: "Gray secondary clicked") ?? .gray
            static let inactiveStateColor : UIColor = UIColor(named: "Gray secondary inactive") ?? .gray
            static let defaultStateTextColor: UIColor = UIColor(named: "Text main") ?? .black
            static let clickedStateTextColor: UIColor = UIColor(named: "Text main") ?? .black
            static let inactiveTextColor: UIColor = UIColor(named: "Text disabled") ?? .gray
        }

        enum UILabel {
            static let font: UIFont = UIFont(name: "SF Pro Text", size: 17) ?? .systemFont(ofSize: 17)
            static let titleText: String = "Label-2"
        }

        enum UIButton {
            static let cornerRadius: CGFloat = 10
        }
    }

    enum States {
        case `default`
        case clicked
        case inactive
    }
}
