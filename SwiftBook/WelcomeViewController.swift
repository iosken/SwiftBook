//
//  WelcomeViewController.swift
//  SwiftBook
//
//  Created by Yuri on 08.01.2023.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet var welcomeLabel: UILabel!
    @IBOutlet var smileLabel: UILabel!
    
    var welcomeLabelText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeLabel.text = welcomeLabelText
        smileLabel.text = "👋"
        smileLabel.font = smileLabel.font.withSize(40)
    }
}
