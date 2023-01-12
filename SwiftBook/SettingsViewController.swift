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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func cancelButtonPressed() {
        dismiss(animated: true)
    }
}
