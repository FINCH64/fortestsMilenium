//
//  VerificationCodeTextField.swift
//  fortests
//
//  Created by Alexey on 30.07.24.
//

import UIKit

//MARK: - Verification text field implementation

class VerificationCodeTextField: UITextField {
    
    private var didEnterLastDigitAction: ((String) -> ())?
    private var isConfigured: Bool = false
    private var digitLabels = [UILabel]()
    private var digitCells = [UICollectionViewCell]()
    private lazy var tapRecoghnizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(becomeFirstResponder))
        return recognizer
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateState(toState: States) {
        switch toState {
        case .empty:
            setCellsStyle(borderColor: Constants.Colors.emptyStatecolor,
                          labelColor: Constants.Colors.emptyStateDigitColor	,
                          withAnimation: false)
        case .typing:
            setCellsStyle(borderColor: Constants.Colors.typingStateColor,
                          labelColor: Constants.Colors.typingStateDigitColor    ,
                          withAnimation: false)
        case .sucess:
            setCellsStyle(borderColor: Constants.Colors.sucessStateColor,
                          labelColor: Constants.Colors.sucessStateDigitColor    ,
                          withAnimation: false)
        case .error:
            setCellsStyle(borderColor: Constants.Colors.errorStateColor,
                          labelColor: Constants.Colors.errorStateDigitColor    ,
                          withAnimation: true)
        }
    }
    
    func setCellsStyle(borderColor: UIColor,labelColor: UIColor,withAnimation: Bool) {
        digitCells.forEach {cell in
            cell.contentView.layer.borderColor = borderColor.cgColor
        }
        
        digitLabels.forEach{label in
            label.textColor = labelColor
        }
        
        //for change to error state
        if withAnimation {
            shake(Constants.ShakeAnimation.timesRepeat, withDelta: Constants.ShakeAnimation.delta)
        }
    }
    
    func setOnLastDigitAction(handler: @escaping ((String) -> ())) {
        didEnterLastDigitAction = handler
    }
}

extension VerificationCodeTextField: UITextFieldDelegate {
    
    //MARK: - Set options
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        guard action != #selector(paste(_:)) else {return super.canPerformAction(action, withSender: sender)}

        return false
    }
    
    //MARK: - Set coursor behavior.
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let newPosition = textField.endOfDocument
        let newRange = textField.textRange(from: newPosition, to: newPosition)
        textField.selectedTextRange = newRange

    }
    
    //disabling auto text selection after finish of editing
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let newPosition = textField.endOfDocument
        let newRange = textField.textRange(from: newPosition, to: newPosition)
        textField.selectedTextRange = newRange
        return true
    }
       
}

private extension VerificationCodeTextField {
    
    //MARK: - UI Setup
    
    private func configure() {
        guard isConfigured == false else {return}

        let stackView = createLabelsStackView(midleSeparator: true)
        addSubview(stackView)
        setupStackViewConstraints(stackView: stackView)
        configureTextField()
        addGestureRecognizer(tapRecoghnizer)
        isConfigured.toggle()
    }
    
    func configureTextField() {
        tintColor = .clear
        textColor = .clear
        font = Constants.UITextField.fontStyle
        keyboardType = .numberPad
        textContentType = .oneTimeCode
        clearsOnInsertion = true
        autocapitalizationType = .none
        autocorrectionType = .no
        smartInsertDeleteType = .no
        smartDashesType = .no
        smartQuotesType = .no
        spellCheckingType = .no
        returnKeyType = .done
        clearsOnBeginEditing = false
        
        addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        addTarget(self, action: #selector(editingStarted), for: .editingDidBegin)
        
        delegate = self
    }
    
    func createLabelsStackView(midleSeparator: Bool = false) -> UIStackView {
        let stackView = UIStackView()
        let count = Constants.UIStackView.cellsCount
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = Constants.UIStackView.spacingBetweenCells
        
        for index in 1...count {
            let cell = UICollectionViewCell()
            let label = UILabel()
            
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.font = Constants.UILabel.digitFontStyle
            label.isUserInteractionEnabled = true
            label.text = Constants.UILabel.labelPlaceholder
            
            cell.contentView.addSubview(label)
            cell.contentView.layer.cornerRadius = Constants.UICollectionViewCell.cellCornerRadius
            cell.contentView.layer.borderWidth = Constants.UICollectionViewCell.cellBorderWidth
            cell.contentView.backgroundColor = .white
            setupCellsLabelConstraints(label: label, cell: cell)
            
            digitCells.append(cell)
            digitLabels.append(label)
            stackView.addArrangedSubview(cell)
            
            if midleSeparator == true && index == count/2 {
                stackView.addArrangedSubview(createSeparatorLabel())
            }
        }
        
        updateState(toState: .empty)
        
        return stackView
    }
    
    func createSeparatorLabel() -> UILabel {
        let slashLabel = UILabel()
        
        slashLabel.translatesAutoresizingMaskIntoConstraints = false
        slashLabel.text = Constants.Separator.digitsSeparator
        slashLabel.font = Constants.Separator.separatorFontStyle
        slashLabel.textAlignment = .center
        slashLabel.isUserInteractionEnabled = false
        
        return slashLabel
    }
    
    func setupCellsLabelConstraints(label: UILabel,cell: UICollectionViewCell) {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal,
                               toItem: cell, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal,
                               toItem: cell, attribute: .centerY, multiplier: 1, constant: 0),
        ])
    }
    
    func setupStackViewConstraints(stackView: UIStackView) {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
    //MARK: - Setup behavior
    
    @objc
    private func textDidChange() {
        guard let text = text, text.count <= digitLabels.count else {return}
        
        for i in 0 ..< digitLabels.count {
            let currentLabel = digitLabels[i]
            
            if i < text.count {
                let index = text.index(text.startIndex, offsetBy: i)
                currentLabel.text = String(text[index])
            } else {
                currentLabel.text? = Constants.UILabel.labelPlaceholder
            }
        }
        
        if text.count == digitLabels.count {
            didEnterLastDigitAction?(text)
        }
    }
    
    @objc
    private func editingStarted() {
        updateState(toState: .typing)
    }
}
