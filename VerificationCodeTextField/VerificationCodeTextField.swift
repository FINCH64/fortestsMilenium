//
//  VerificationCodeTextField.swift
//  fortests
//
//  Created by Alexey on 30.07.24.
//

import Foundation
import UIKit

//MARK: Constants

enum CodeCellsStyles {
    static let emptyStatecolor: UIColor = UIColor(named: "Grey 400") ?? UIColor.white
    
    static let typingStateColor : UIColor = UIColor(named: "Blue 400") ?? UIColor.blue
    
    static let typingStateDigitColor : UIColor = .black
    
    static let sucessStateColor: UIColor = UIColor(named: "Blue 500") ?? UIColor.green
    
    static let errorStateColor: UIColor = UIColor(named: "Red 500") ?? UIColor.red
    
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

//Mark: Verification text field implementation
class VerificationCodeTextField: UITextField {
    
    var didEnterLastDigit: ((String) -> ())?
    private var isConfigured: Bool = false
    private var digitLabels = [UILabel]()
    private var digitCells = [UICollectionViewCell]()
    
    private lazy var tapRecoghnizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        
        recognizer.addTarget(self, action: #selector(becomeFirstResponder))
        return recognizer
    }()
    
    func configure() {
        guard isConfigured == false else {return}

        let stackView = createLabelsStackView(midleSeparator: true)

        configureTextField()
        addSubview(stackView)
        addGestureRecognizer(tapRecoghnizer)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        
        isConfigured.toggle()
    }
    
    func configureTextField() {
        tintColor = .clear
        textColor = .clear
        font = UIFont.systemFont(ofSize: 20)
        keyboardType = .numberPad
        //textContentType = .oneTimeCode
        clearsOnInsertion = true
        autocapitalizationType = .none
        autocorrectionType = .no
        smartInsertDeleteType = .no
        smartDashesType = .no
        smartQuotesType = .no
        spellCheckingType = .no
        returnKeyType = .done
        
        addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        addTarget(self, action: #selector(editingStarted), for: .editingDidBegin)
        
        delegate = self
    }
    
    func createLabelsStackView(midleSeparator: Bool = false) -> UIStackView {
        let stackView = UIStackView()
        let count = CodeCellsStyles.defaultCellsCount
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = CodeCellsStyles.spacingBetweenCells
        
        
        for index in 1...count {
            let cell = UICollectionViewCell()
            let label = UILabel()
            
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.font = CodeCellsStyles.digitFontStyle
            label.isUserInteractionEnabled = true
            label.text = CodeCellsStyles.labelPlaceholder
            cell.contentView.addSubview(label)
            cell.contentView.layer.cornerRadius = CodeCellsStyles.cellCornerRadius
            cell.contentView.layer.borderWidth = CodeCellsStyles.cellBorderWidth
            cell.contentView.backgroundColor = .white
            
            NSLayoutConstraint.activate([
                NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: cell, attribute: .centerX, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: cell, attribute: .centerY, multiplier: 1, constant: 0),
            ])
            
            digitCells.append(cell)
            digitLabels.append(label)
            
            stackView.addArrangedSubview(cell)
            
            if midleSeparator == true && index == count/2 {
                let slashLabel = UILabel()
                let slashCell = UICollectionViewCell()
                
                slashLabel.translatesAutoresizingMaskIntoConstraints = false
                slashLabel.text = CodeCellsStyles.digitsSeparator
                slashLabel.font = CodeCellsStyles.digitFontStyle
                slashLabel.textAlignment = .center
                slashLabel.isUserInteractionEnabled = false
                
                slashCell.contentView.addSubview(slashLabel)
                stackView.addArrangedSubview(slashLabel)
            }
        }
        
        setCellsStyle(borderColor: CodeCellsStyles.emptyStatecolor, labelColor: CodeCellsStyles.emptyStatecolor)
        
        return stackView
    }
    
    @objc
    private func textDidChange() {
        guard let text = self.text, text.count <= digitLabels.count else {return}
        
        for i in 0 ..< digitLabels.count {
            let currentLabel = digitLabels[i]
            
            if i < text.count {
                let index = text.index(text.startIndex, offsetBy: i)
                currentLabel.text = String(text[index])
            } else {
                currentLabel.text? = CodeCellsStyles.labelPlaceholder
            }
        }
        
        if text.count == digitLabels.count {
            
            setCellsStyle(borderColor: CodeCellsStyles.sucessStateColor, labelColor: CodeCellsStyles.sucessStateColor)
            didEnterLastDigit?(text)
        }
    }
    
    @objc
    private func editingStarted() {
        setCellsStyle(borderColor: CodeCellsStyles.typingStateColor, labelColor: CodeCellsStyles.typingStateDigitColor)
    }
    
    func isOnlyDigitsInString(string: String) -> Bool {
        let digits = CharacterSet.decimalDigits
        let stringSet = CharacterSet(charactersIn: string)

        return digits.isSuperset(of: stringSet)
    }
    
    func setCellsStyle(borderColor: UIColor,labelColor: UIColor) {
        digitCells.forEach {cell in
            cell.contentView.layer.borderColor = borderColor.cgColor
        }
        
        digitLabels.forEach{label in
            label.textColor = labelColor
        }
    }
    
}

extension VerificationCodeTextField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if !isOnlyDigitsInString(string: string) {
            setCellsStyle(borderColor: CodeCellsStyles.errorStateColor, labelColor: CodeCellsStyles.errorStateColor)
            //call alert function indicating that you can input only numbers
            return false
        } else {
            setCellsStyle(borderColor: CodeCellsStyles.typingStateColor, labelColor: CodeCellsStyles.typingStateDigitColor)
        }
        
        if string.count > 1 {
            textField.text?.removeAll()
        }
        
        let charactersOldCount = textField.text?.count ?? 0
        let charactersNewCount = string.count
        let charactersCountAfterEditing = charactersOldCount + charactersNewCount
        
        if charactersOldCount == 6 && charactersNewCount != 0 {
            return false
        }
        
        if charactersCountAfterEditing > CodeCellsStyles.defaultCellsCount {
            let startIndex = string.startIndex
            let lowerIndex = string.index(startIndex, offsetBy: 0)
            let upperIndex = string.index(startIndex, offsetBy: CodeCellsStyles.defaultCellsCount)

            textField.text?.append(String(string[lowerIndex..<upperIndex]))

            self.textDidChange()
            return false
        }
        
        return true
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        guard action != #selector(paste(_:)) else {return super.canPerformAction(action, withSender: sender)}

        return false
    }
}
