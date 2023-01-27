//
//  WelcomeViewController.swift
//  SwiftBook
//
//  Created by Yuri on 08.01.2023.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    //MARK: - IB Outlets
    @IBOutlet var welcomeLabel: UILabel!
    @IBOutlet var smileLabel: UILabel!
    
    //MARK: - Properties
    var userName: String!
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layer.insertSublayer(
            DesignMethod.gradientLayer(bounds: self.view.bounds),
            at: 0
        )
        
        welcomeLabel.text = "Welcome, " + userName + "!"
    }
    
    //MARK: - IB Actions
    @IBAction func logOutButtonPressed() {
        performSegue(withIdentifier: "WelcomeViewControllerID", sender: self)
    }
}
