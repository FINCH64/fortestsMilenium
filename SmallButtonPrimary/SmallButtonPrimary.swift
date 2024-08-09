//
//  SmallButton.swift
//  fortests
//
//  Created by Alexey on 8.08.24.
//

import UIKit

// MARK: - Implement SecondaryButtonPrimary

class SmallButtonPrimary: UIButton {

    private var didPressedAction: (() -> ())?
    private var isConfigured: Bool = false

    public init(frame: CGRect, title: String?) {
        super.init(frame: frame)
        configure(titleText: title)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateState(toState: States) {
        switch toState {
        case .`default`:
            setButtonStyle(newBackgroundColor: Constants.Colors.defaultStateColor)
        case .clicked:
            setButtonStyle(newBackgroundColor: Constants.Colors.clickedStateColor)
        }
    }
    
    func setButtonStyle(newBackgroundColor: UIColor) {
        backgroundColor = newBackgroundColor
    }

    func setTouchHandler(handler: @escaping (() -> ())) {
        didPressedAction = handler
    }

    // MARK: - Setup behavior

    @IBAction override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        didPressedAction?()
        updateState(toState: .clicked)
    }
    
    @IBAction override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        updateState(toState: .default)
    }
    
    @IBAction override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        updateState(toState: .default)
    }
}

private extension SmallButtonPrimary {

    // MARK: - UI Setup

    private func configure(titleText: String?) {
        guard isConfigured == false else {return}
        
        setTitle(titleText ?? Constants.UILabel.titleText, for: .normal)
        setTitleColor(Constants.Colors.defaultTextColor , for: .normal)
        layer.cornerRadius = Constants.UIButton.cornerRadius
        updateState(toState: .default)
        isConfigured.toggle()
    }
}
