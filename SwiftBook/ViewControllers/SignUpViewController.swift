//
//  SignUpViewController.swift
//  SwiftBook
//
//  Created by Yuri on 20.01.2023.
//

import UIKit

class SignUpViewController: UIViewController {
    
    //MARK: - IB Outlets
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var secondNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var aboutUserTextField: UITextField!
    
    //MARK: - Related Properties
    var userNameEntered: String? // transfer from LoginViewController.userNameTextField to SignUpViewController.loginTextField
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }
    
    //MARK: - Lifecycle Methods:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layer.insertSublayer(
            DesignMethod.gradientLayer(bounds: self.view.bounds),
            at: 0
        )
        
        loginTextField.text = userNameEntered ?? ""
    }
    
    //MARK: - IB Actions
    
    @IBAction func cancelButtonPressed() {
        dismiss(animated: true)
    }
    
    @IBAction func submitButtonPressed() {
        guard (loginTextField.text ?? "") != "" &&
                (3...24).contains((loginTextField.text ?? "").count) &&
                (loginTextField.text ?? "").first?.wholeNumberValue == nil else {
            showAlert(with: "Oops!", and: "Please enter New Login with 3-24 symbols (first symbol cant be number) and please fill all the fields with \"*\" mark!")
            return
        }
        guard (passwordTextField.text ?? "") != "" &&
                (5...24).contains((passwordTextField.text ?? "").count) else {
            showAlert(with: "Oops!", and: "Please enter Password with 5-24 symbols and please fill all the fields with \"*\" mark!")
            return
        }
        guard (firstNameTextField.text ?? "") != "" &&
                (1...24).contains((firstNameTextField.text ?? "").count) else {
            showAlert(with: "Oops!", and: "Please fill all the fields with \"*\" mark!")
            return
        }
        guard (secondNameTextField.text ?? "") != "" &&
                (1...24).contains((secondNameTextField.text ?? "").count) else {
            showAlert(with: "Oops!", and: "Please fill all the fields with \"*\" mark!")
            return
        }
        guard (emailTextField.text ?? "") != "" &&
                (4...24).contains((secondNameTextField.text ?? "").count) else {
            showAlert(with: "Oops!", and: "Please fill field e-mail with 4...24 symbols!")
            return
        }
        
        performSegue(withIdentifier: "SignUpID", sender: self)
    }
    
}

// MARK: - UIAlertController
extension SignUpViewController {
    private func showAlert(with title: String, and message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
