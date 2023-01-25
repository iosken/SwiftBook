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
    @IBOutlet var aboutUserTextField: UITextField!
    @IBOutlet var aboutPetsTextField: UITextField!
    @IBOutlet var aboutSportsTextField: UITextField!
    
    var userNameEntered: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginTextField.text = userNameEntered ?? ""
    }
    
    @IBAction func cancelButtonPressed() {
        dismiss(animated: true)
    }

    @IBAction func submitButtonPressed() {
        print("called")
        performSegue(withIdentifier: "SignUpID", sender: self)
    }
}
