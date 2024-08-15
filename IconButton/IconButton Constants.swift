//
//  IconButton Constants.swift
//  fortests
//
//  Created by Alexey on 9.08.24.
//

import UIKit

extension IconButton {

    enum Constants {

        enum Colors {
            static let tintColor: UIColor = .lightGray
        }
        
        enum Sizes {
            static let buttonWidth: CGFloat = 40
            static let buttonHeight: CGFloat = 40
            static let buttonOpacity: CGFloat = 0.62
        }

        enum Images {
            static let checkImage = UIImage(named: "eye-open")?.withRenderingMode(.alwaysTemplate)
            static let uncheckedImge = UIImage(named: "eye-closed")?.withRenderingMode(.alwaysTemplate)
        }
    }
}
