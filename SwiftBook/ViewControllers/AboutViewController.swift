//
//  AboutViewController.swift
//  SwiftBook
//
//  Created by Yuri on 18.01.2023.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet var aboutTextView: UITextView!
    
    var aboutPerson: String!
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layer.insertSublayer(
            UIViewController.gradientLayer(bounds: self.view.bounds),
            at: 0
        )
    
        aboutTextView.text = aboutPerson
        
        print(aboutPerson ?? "")
    }
    
}
