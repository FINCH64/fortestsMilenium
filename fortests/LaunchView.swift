//
//  LaunchView.swift
//  fortests
//
//  Created by Alexey on 29.07.24.
//

import UIKit

class LaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.systemPink
        
        let launchLabel = UILabel()
        launchLabel.font = UIFont(name: "System Bold", size: 30)
        self.view.addSubview(launchLabel)
        
    }


}

