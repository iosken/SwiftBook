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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        helpTextView.text = helpText
        
        self.view.layer.insertSublayer(
            UIViewController.gradientLayer(bounds: self.view.bounds),
            at: 0
        )        
    }
}
