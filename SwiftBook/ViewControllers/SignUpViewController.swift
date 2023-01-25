//
//  SignUpViewController.swift
//  SwiftBook
//
//  Created by Yuri on 20.01.2023.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var secondNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var aboutUserTextField: UITextField!
    
    var userNameEntered: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layer.insertSublayer(
            UIViewController.gradientLayer(bounds: self.view.bounds),
            at: 0
        )
        
        loginTextField.text = userNameEntered ?? ""
    }
    
    @IBAction func cancelButtonPressed() {
        dismiss(animated: true)
    }

    @IBAction func submitButtonPressed() {
        print("called")
        performSegue(withIdentifier: "SignUpID", sender: self)
    }
    
//    func setGradientBackground() {
//        let gradientLayer = CAGradientLayer()
//
//        gradientLayer.colors = [#colorLiteral(red: 1, green: 0.9042130062, blue: 0.8607816224, alpha: 1).cgColor, #colorLiteral(red: 0.9233794142, green: 1, blue: 0.8758689237, alpha: 1).cgColor, #colorLiteral(red: 0.8862585912, green: 0.9864693626, blue: 1, alpha: 1).cgColor, #colorLiteral(red: 0.9574609403, green: 0.9686274529, blue: 0.541431185, alpha: 1).cgColor]
//        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
//        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
//        gradientLayer.locations = [0, 0.25, 0.93, 1]
//        gradientLayer.frame = self.view.bounds
//
//        self.view.layer.insertSublayer(gradientLayer, at: 0)
//    }
}
