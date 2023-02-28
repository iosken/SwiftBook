//
//  AboutViewController.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 27.02.2023.
//

import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet var phoneNumber: UILabel!
    @IBOutlet var email: UILabel!
    
    var person: Person!
    
    // MARK: - Overrided Properties
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = person.fullName
        
        phoneNumber.text = person.phoneNumber
        
        email.text = person.email
    }
    
}
