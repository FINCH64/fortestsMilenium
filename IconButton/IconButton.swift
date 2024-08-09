//
//  IconButton.swift
//  fortests
//
//  Created by Alexey on 9.08.24.
//

import UIKit

// MARK: - Implement IconButton

class IconButton: UIButton {

    private var didPressedAction: (() -> Void)?
    private var isConfigured: Bool = false

    public init(frame: CGRect, title: String?) {
        super.init(frame: frame)
        configure(titleText: title)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setTouchHandler(handler: @escaping (() -> ())) {
        didPressedAction = handler
    }
}

private extension IconButton {

    // MARK: - UI Setup

    private func configure(titleText: String?) {
        guard isConfigured == false else {return}

        self.setBackgroundImage(Constants.defaultIcon, for: .normal)
        self.setBackgroundImage(Constants.selectedIcon, for: .se)
        isConfigured.toggle()
    }
}
