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
    @IBOutlet var userPasswordTextField: UITextField!
    
    @IBOutlet var logInButton: UIButton!
    
    // MARK: - Private Properties
    
    
    let  signedUsers = SignedUsers()
    
    // MARK: - Overrided Properties
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }
    
    // MARK: - Overrided Methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    // MARK: - Prepare and Unwind Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "TabBarID":
            guard let tabBarVC = segue.destination as? UITabBarController else { return }
            
            tabBarVC.modalPresentationStyle = .fullScreen
            tabBarVC.modalTransitionStyle = .crossDissolve
            
            guard let viewControllers = tabBarVC.viewControllers else { return }
            
            viewControllers.forEach { viewController in
                if let welcomeVC = viewController as? WelcomeViewController {
                    welcomeVC.userName = userNameTextField.text ?? ""
                }
//                else if let aboutVC = viewController as? UINavigationBar {
//                    
//                }
            }
        case "SignUpID":
            guard let signUpVC = segue.destination as? SignUpViewController else { break }
            signUpVC.userNameEntered = userNameTextField.text
        default:
            break
        }
    }
    
    @IBAction func unwindToLogin(for segue: UIStoryboardSegue) {
        print("Unwind called with \(segue.identifier ?? "NIL") and \(segue)")
        for value in signedUsers.users.values {
            print()
            print(value.password)
        }
        
        switch segue.identifier {
        case "MainToWelcomeViewControllerID":
            userNameTextField.text = ""
            userPasswordTextField.text = ""
        case "SignUpID":
            print("Unwind SignUpID called")
            
            let signUp = segue.source as? SignUpViewController
            
            signedUsers.signUp(
                login: signUp?.loginTextField.text ?? "",
                password: signUp?.passwordTextField.text ?? "",
                recoveryEmail: signUp?.loginTextField.text ?? "",
                firstName: signUp?.firstNameTextField.text ?? "",
                secondName: signUp?.secondNameTextField.text ?? "",
                about: signUp?.aboutUserTextField.text ?? "",
                pet: signUp?.aboutPetsTextField.text ?? "",
                sport: signUp?.aboutSportsTextField.text ?? ""
            )
        default:
            break
        }
    }
    
    // MARK: - IB Actions
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        let inputLogin = userNameTextField.text ?? ""
        let inputPassword = userPasswordTextField.text ?? ""
        
        print(signedUsers.users[inputLogin]?.password ?? "some")
        
        if let storedPassword = signedUsers.users[inputLogin]?.password {
            if storedPassword == inputPassword {
                performSegue(
                    withIdentifier: "TabBarID",
                    sender: nil
                )
            } else {
                showAlert(
                    with: "Invalid login or password",
                    and: "Please, enter correct login and password"
                )
                userPasswordTextField.text = ""
            }
        } else {
            showAlert(
                with: "Invalid login or password",
                and: "Please, enter correct login and password"
            )
            
            userPasswordTextField.text = ""
        }
    }
    
    @IBAction func forgotNameButtonPressed(_ sender: UIButton) {
        var accounts = ""
        for (user, account) in signedUsers.users {
            accounts += (user + " " + account.password + " || ")
        }
        showAlert(with: "Oops!", and: "Your name is: \("Default name is: \"User\"") and another: \n \(accounts) 😉")
        
    }
    
    @IBAction func forgotPasswordButtonPressed(_ sender: UIButton) {
        showAlert(
            with: "Oops!",
            and: "Your password is: \(signedUsers.users["User"]?.password ?? "Error with default user stored data. Look at signedUsers.users[\"User\"]?.password")"
        )
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
