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
            static let emptyStatecolor: UIColor = UIColor(named: "Grey 400") ?? .white
            static let typingStateColor : UIColor = UIColor(named: "Blue 400") ?? .blue
            static let sucessStateColor: UIColor = UIColor(named: "Blue 500") ?? .blue
            static let errorStateColor: UIColor = UIColor(named: "Red 500") ?? .red
            static let emptyStateDigitColor : UIColor = UIColor(named: "Grey 300") ?? .gray
            static let typingStateDigitColor : UIColor = .black
            static let sucessStateDigitColor: UIColor = UIColor(named: "Blue 500") ?? .blue
            static let errorStateDigitColor: UIColor = UIColor(named: "Red 500") ?? .red
        }

        enum UIStackView {
            static let spacingBetweenCells: CGFloat = 4
            static let cellsCount: Int = 6
        }

        enum UITextField {
            static let fontStyle: UIFont = UIFont(name: "Roboto", size: 16) ?? UIFont.systemFont(ofSize: 16)
        }

        enum UICollectionViewCell {
            static let cellCornerRadius: CGFloat = 8
            static let cellBorderWidth: CGFloat = 4
            static let cellHeight: CGFloat = 40
            static let cellWidth: CGFloat = 36
        }

        enum UILabel {
            static let labelPlaceholder: String = "0"
            static let digitFontStyle: UIFont = UIFont(name: "Roboto", size: 16) ?? UIFont.systemFont(ofSize: 16)
        }

        enum Separator {
            static let separatorFontStyle: UIFont = UIFont(name: "Roboto", size: 16) ?? UIFont.systemFont(ofSize: 16)
            static let digitsSeparator: String = "-"
            static let separatorWidth: CGFloat = 20
        }
        
        enum ShakeAnimation{
            static let timesRepeat: Int = 10
            static let delta: CGFloat = 1
        }
    }

    enum States {
        case empty
        case typing
        case sucess
        case error
    }

}
