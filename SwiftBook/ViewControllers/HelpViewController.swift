//
//  HelpViewController.swift
//  SwiftBook
//
//  Created by Yuri on 25.01.2023.
//

import UIKit

class HelpViewController: UIViewController {
    @IBOutlet var helpTextView: UITextView!
    
    var helpText: String!
    var currentUserName: String!
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let signUpViewController = segue.destination as? SignUpViewController else { return }
//        signUpViewController.loginTextField.text = currentUserName
//        
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        helpTextView.text = helpText
        
        self.view.layer.insertSublayer(
            UIViewController.gradientLayer(bounds: self.view.bounds),
            at: 0
        )        
    }

    @IBAction func showPropertiesBarButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "HepToPropertiesID", sender: self)
    }
}
