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
    
    var userNameEntered: String? // transfer from LoginViewController.userNameTextField to SignUpViewController.loginTextField
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layer.insertSublayer(
            DesignMethod.gradientLayer(bounds: self.view.bounds),
            at: 0
        )
        
        loginTextField.text = userNameEntered ?? ""
    }
    

    @IBAction func unwindToSignUpViewController(for unwindSegue: UIStoryboardSegue) {
        print("===Unwind called!")
    }
    
    @IBAction func cancelButtonPressed() {
        dismiss(animated: true)
    }

    @IBAction func submitButtonPressed() {
        guard (loginTextField.text ?? "") != "" && (loginTextField.text ?? "").count > 3 else {
            showAlert(with: "Oops!", and: "Please enter New Login with more then 3 symbols and please fill all the fields with \"*\" mark!")
            return
        }
        guard (passwordTextField.text ?? "") != "" && (passwordTextField.text ?? "").count > 5 else {
            showAlert(with: "Oops!", and: "Please enter Password with more then 5 symbols and please fill all the fields with \"*\" mark!")
            return
        }
        guard (firstNameTextField.text ?? "") != "" else {
            showAlert(with: "Oops!", and: "Please fill all the fields with \"*\" mark!")
            return
        }
        guard (secondNameTextField.text ?? "") != "" else {
            showAlert(with: "Oops!", and: "Please fill all the fields with \"*\" mark!")
            return
        }
        guard (emailTextField.text ?? "") != "" else {
            showAlert(with: "Oops!", and: "Please fill e-mail field wich is marked \"*\"!")
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
