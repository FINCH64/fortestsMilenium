//
//  ViewController.swift
//  fortests
//
//  Created by Alexey on 29.07.24.
//
import UIKit

class ViewController: UIViewController {
    
    //let microserviceForVeryfiing: MicroService = someService
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let verificationCodeTextField = VerificationCodeTextField(frame: CGRect(x: 50, y: 300, width: 293, height: 40))
    
        verificationCodeTextField.setOnLastDigitAction(handler: { [weak self] code in
            print(code)
            //guard let microserviceForVeryfiing = microserviceForVeryfiing.shared
            //if let microserviceForVeryfiing.shared.verify {
            //do some logic or screen transition
            //}
            
            let alert = UIAlertController(title: "Sucess", message: "You sucessifuly logged in with code - \(code)!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            
            alert.addAction(okAction)
            
            self?.present(alert,animated: true)
        })
        
        let primaryButton = PrimaryButton(frame: CGRect(x: 20, y: 600, width: 200, height: 48), title: "Label2")
        primaryButton.setTouchHandler(handler: {
            //guard let microserviceForVeryfiing = microserviceForVeryfiing.shared
            //if let microserviceForVeryfiing.shared.verify {
            //do some logic or screen transition
            //}
            
            let alert = UIAlertController(title: "Sucess", message: "You sucessifuly logged in with code - !", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            
            alert.addAction(okAction)
            
            self.present(alert,animated: true)
            primaryButton.updateState(toState: .inactive)
            //primaryButton.isEnabled = false
        })
        
        self.view.addSubview(verificationCodeTextField)
        self.view.addSubview(primaryButton)
        
//        NSLayoutConstraint.activate([
//            NSLayoutConstraint(item: verificationCodeTextField, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
//            NSLayoutConstraint(item: verificationCodeTextField, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0),
//        ])
        
    }


}

