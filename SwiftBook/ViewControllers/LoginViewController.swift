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
    
    // MARK: - Private Properties
    
    let signedUsers = UsersDatabase()
    
    // MARK: - Overrided Properties
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }
    
    // MARK: - Overrided Life Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layer.insertSublayer(
            DesignMethod.gradientLayer(bounds: self.view.bounds),
            at: 0
        )
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
            signedUsers.currentUserName = userNameTextField.text ?? ""
            
            guard let tabBarVC = segue.destination as? UITabBarController else { return }
            
            guard let viewControllers = tabBarVC.viewControllers else { return }
            
            viewControllers.forEach { viewController in
                if let welcomeVC = viewController as? WelcomeViewController {
                    welcomeVC.userName = userNameTextField.text ?? ""
                    
                } else if let navigationVC = viewController as? UINavigationController {
                    
                    if let aboutVC = navigationVC.topViewController as? AboutViewController {
                        aboutVC.title = "About \(signedUsers.currentUserProperties?.person.firstName ?? "") \(signedUsers.currentUserProperties?.person.secondName ?? "")"
                        aboutVC.aboutPerson = signedUsers.currentUserProperties?.person.about
                        
                    } else if let helpVC = navigationVC.topViewController as? HelpViewController {
                        helpVC.helpText = "Hello my dear friend, \(signedUsers.currentUserProperties?.person.firstName ?? ""). This is my training programm and you can try to close it and forget it forever. \n\n But I reporting: this text I setted from first ViewController with your name. \n\n Good luck and be happy you and your family!"
                        helpVC.currentUserProperties = signedUsers.currentUserProperties
                    }
                    
                }
            }
        case "SignUpID":
            guard let signUpVC = segue.destination as? SignUpViewController else { break }
            signUpVC.userNameEntered = userNameTextField.text
        default:
            break
        }
    }
    
    @IBAction func unwindToLogin(for segue: UIStoryboardSegue) {
        switch segue.identifier {
        case "WelcomeViewControllerID":
            userNameTextField.text = ""
            userPasswordTextField.text = ""
        case "SignUpID":
            let signUp = segue.source as? SignUpViewController
            
            signedUsers.signUp(
                login: signUp?.loginTextField.text ?? "",
                password: signUp?.passwordTextField.text ?? "",
                recoveryEmail: signUp?.emailTextField.text ?? "",
                firstName: signUp?.firstNameTextField.text ?? "",
                secondName: signUp?.secondNameTextField.text ?? "",
                about: signUp?.aboutUserTextField.text ?? ""
            )
            
        default:
            break
        }
    }
    
    // MARK: - IB Actions
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        let inputLogin = userNameTextField.text ?? ""
        let inputPassword = userPasswordTextField.text ?? ""
        
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
        
        showAlert(
            with: "Oops!",
            and: "All autorization data is: \n \(accounts) 😉"
        )
        
    }
    
    @IBAction func forgotPasswordButtonPressed(_ sender: UIButton) {
        showAlert(
            with: "Oops!",
            and: "Your password is: \(signedUsers.currentUserProperties?.password ?? "Error with default user stored data. Look at signedUsers.users[\"User\"]?.password")"
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


