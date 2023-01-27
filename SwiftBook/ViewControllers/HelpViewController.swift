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
    
    var currentUserProperties: UserProperties!
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let showPropertiesVC = segue.destination as? ShowPropertiesViewController else { return }

        showPropertiesVC.userProperties = currentUserProperties
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        helpTextView.text = helpText
        
        self.view.layer.insertSublayer(
            DesignMethod.gradientLayer(bounds: self.view.bounds),
            at: 0
        )        
    }

    @IBAction func showPropertiesBarButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "HepToPropertiesID", sender: self)
    }
}
