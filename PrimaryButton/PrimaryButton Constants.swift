//
//  PrimaryButton Constants.swift
//  fortests
//
//  Created by Alexey on 6.08.24.
//

import UIKit

extension PrimaryButton {

    enum Constants {

        enum Colors {
            static let defaultStateColor : UIColor = UIColor(named: "Blue 400") ?? .blue
            static let clickedStateColor : UIColor = UIColor(named: "Blue 500") ?? .blue
            static let inactiveStateColor : UIColor = UIColor(named: "Grey 300") ?? .gray
            static let loadingStateColor : UIColor = UIColor(named: "Blue 400") ?? .blue
            static let defaultStateTextColor: UIColor = .white
            static let clickedStateTextColor: UIColor = .white
            static let loadingStateTextColor: UIColor = .white
            static let inactiveTextColor: UIColor = .black
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
        case loading
    }
}
