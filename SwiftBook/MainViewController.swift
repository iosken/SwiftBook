//
//  ViewController.swift
//  SwiftBook
//
//  Created by Yuri on 15.12.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var logInButton: UIButton!
    
    private let login = "User"
    private let password = "1234"
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
           .portrait
       }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super .touchesBegan(touches, with: event)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func shouldPerformSegue(
        withIdentifier identifier: String?,
        sender: Any?
    ) -> Bool {
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let welcomeVC = segue.destination as? WelcomeViewController else {
            return
        }
        
        welcomeVC.modalPresentationStyle = .fullScreen
        welcomeVC.modalTransitionStyle = .crossDissolve
        
        welcomeVC.welcomeLabelText = "Welcome, \(userNameTextField.text ?? "")"
    }
    
    @IBAction func logInButtonPressed(_ sender: UIButton) {
        guard let inputLogin = userNameTextField.text, !inputLogin.isEmpty else {
            showAlert(
                with: "Empty login",
                and: "Please enter correct login and password"
            )
            return
        }
        
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
extension MainViewController {
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
