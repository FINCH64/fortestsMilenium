//
//  IconButton Constants.swift
//  fortests
//
//  Created by Alexey on 9.08.24.
//

import UIKit

extension IconButton {

    enum Constants {
        static let defaultIcon = UIImage(systemName: "eye-open")
        static let selectedIcon = UIImage(systemName: "eye-closed")
        static let iconOpacity = 0.38
    }

    enum States {
        case `default`
        case clicked
    }
}
