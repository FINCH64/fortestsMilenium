//
//  PrimaryButton.swift
//  fortests
//
//  Created by Alexey on 6.08.24.
//

import UIKit

//MARK: - Implement PrimaryButton

class PrimaryButton: UIButton {
    
    private var didPressedAction: (() -> ())?
    private var isConfigured: Bool = false
    
    public init(frame: CGRect, title: String?) {
        super.init(frame: frame)
        configure(titleText: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setButtonStyle(newBackgroundColor: UIColor) {
        backgroundColor = newBackgroundColor
    }
    
    func setTouchHandler(handler: @escaping (() -> ())) {
        didPressedAction = handler
    }
}

private extension PrimaryButton {
    
    //MARK: - UI Setup
    
    private func configure(titleText: String?) {
        guard isConfigured == false else {return}
        
        setTitle(titleText ?? Constants.UILabel.titleText, for: .normal)
        setTitleColor(Constants.Colors.activeTextColor , for: .normal)
        setTitleColor(Constants.Colors.inactiveTextColor, for: .disabled)
        layer.cornerRadius = Constants.UIButton.cornerRadius
        setButtonStyle(newBackgroundColor: Constants.Colors.defaultStateColor)
        addTarget(self, action: #selector(touchDown), for: .touchDown)
        isConfigured.toggle()
    }
    
    //MARK: - Setup behavior
    
    @objc
    private func touchDown() {
        didPressedAction?()
        setButtonStyle(newBackgroundColor: Constants.Colors.clickedStateColor)
    }
    
}
