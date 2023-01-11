//
//  ViewController.swift
//  SwiftBook
//
//  Created by Yuri on 15.12.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var logInButton: UIButton!
    
    // MARK: - Private Properties
    private var login: String { // computing property hope to little more security
        "User"
    }
    private var password: String {
        "1234"
    }
    
    // MARK: - Overrided Properties
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }
    
    // MARK: - Overrided Methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let welcomeVC = segue.destination as? WelcomeViewController else {
            return
        }
        
        welcomeVC.modalPresentationStyle = .fullScreen
        welcomeVC.modalTransitionStyle = .crossDissolve
        
        welcomeVC.userName = userNameTextField.text ?? ""
    }
    
    // MARK: - IB Actions
    @IBAction func logInButtonPressed(_ sender: UIButton) {
        let inputLogin = userNameTextField.text ?? ""
        let inputPassword = passwordTextField.text ?? ""
        
        if (inputLogin + inputPassword).contains(login + password) {
            performSegue(
                withIdentifier: "MainToWelcomeViewControllerID",
                sender: nil
            )
        } else {
            showAlert(
                with: "Invalid login or password",
                and: "Please, enter correct login and password"
            )
            passwordTextField.text = ""
        }
    }
    
    @IBAction func forgotNameButtonPressed(_ sender: UIButton) {
        showAlert(with: "Oops!", and: "Your name is: \(login) 😉")
    }
    
    @IBAction func forgotPasswordButtonPressed(_ sender: UIButton) {
        showAlert(with: "Oops!", and: "Your password is: \(password)")
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
        userNameTextField.text = ""
        passwordTextField.text = ""
    }
}

// MARK: - UIAlertController
extension LoginViewController {
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
