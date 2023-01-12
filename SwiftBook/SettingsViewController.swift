//
//  SettingsViewController.swift
//  SwiftBook
//
//  Created by Yuri on 11.01.2023.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var minValueTextField: UITextField!
    @IBOutlet var maxValueTextField: UITextField!
    
    var minValue: String!
    var maxValue: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        minValueTextField.text = minValue
        maxValueTextField.text = maxValue
    }
    
    @IBAction func cancelButtonPressed() {
        dismiss(animated: true)
    }
}
