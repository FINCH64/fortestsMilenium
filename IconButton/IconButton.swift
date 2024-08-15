//
//  IconButton.swift
//  fortests
//
//  Created by Alexey on 9.08.24.
//

import UIKit

public class IconButton: UIButton {

    // MARK: - Properties
    private var buttonDidPressed: (() -> Void)?
    public var isChecked: Bool = false {
        didSet {
            setButtonImage()
        }
    }

    // MARK: - UI Components
    private lazy var iconButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame.size = CGSize(width: Constants.Sizes.buttonWidth,
                                   height: Constants.Sizes.buttonHeight)
        //button.backgroundColor = .red
        return button
        
    }()

    // MARK: - LifeCycle
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupButton()
    }

    public init() {
        super.init(frame: .zero)
        setupView()
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Methods

    public func setTouchHandler(handler: @escaping (() -> Void)) {
        buttonDidPressed = handler
    }
}

// MARK: - Checkbox Setup
private extension IconButton {

    func setupButton() {
        iconButton.tintColor = Constants.Colors.tintColor
        setButtonImage()
        iconButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
    }
}

private extension IconButton {

    func setupView() {
        addSubview(iconButton)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: iconButton, attribute: .centerX, relatedBy: .equal,
                               toItem: self, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: iconButton, attribute: .centerY, relatedBy: .equal,
                               toItem: self, attribute: .centerY, multiplier: 1, constant: 0),
        ])
    }
}

private extension IconButton {

    @objc func tapButton() {
        isChecked.toggle()
        setButtonImage()
        buttonDidPressed?()
    }

    func setButtonImage() {
        if isChecked {
            let test = Constants.Images.checkImage
            iconButton.setImage(Constants.Images.checkImage, for: .normal)
        } else {
            let test = Constants.Images.uncheckedImge
            iconButton.setImage(Constants.Images.uncheckedImge, for: .normal)
        }
    }
}
