//
//  VerificationCodeTextField Constants.swift
//  fortests
//
//  Created by Alexey on 6.08.24.
//

import UIKit

extension VerificationCodeTextField {
    
    enum Constants {
        
        enum Colors {
            static let emptyStatecolor: UIColor = UIColor(named: "Grey 400") ?? UIColor.white
            static let typingStateColor : UIColor = UIColor(named: "Blue 400") ?? UIColor.blue
            static let typingStateDigitColor : UIColor = .black
            static let sucessStateColor: UIColor = UIColor(named: "Blue 500") ?? UIColor.green
            static let errorStateColor: UIColor = UIColor(named: "Red 500") ?? UIColor.red
        }
        
        static let spacingBetweenCells: CGFloat = 4
        static let labelPlaceholder: String = "0"
        static let cellCornerRadius: CGFloat = 8
        static let cellBorderWidth: CGFloat = 4
        static let defaultCellsCount: Int = 6
        static let cellHeight: CGFloat = 40
        static let cellWidth: CGFloat = 36
        static let digitFontStyle: UIFont = UIFont(name: "Roboto", size: 16) ?? UIFont.systemFont(ofSize: 16)
        static let textFieldWidth: CGFloat = 293
        static let digitsSeparator: String = "-"
        static let separatorWidth: CGFloat = 60
    }
    
}
