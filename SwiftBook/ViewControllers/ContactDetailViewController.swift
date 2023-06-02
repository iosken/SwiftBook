//
//  ContactDetailViewController.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 02.06.2023.
//

import UIKit

import AlamofireImage

class ContactDetailViewController: UIViewController {
    
    var contact: Contact!

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var contactImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setValues()
    }
    
    private func setValues() {
        nameLabel.text = contact.name.fullName
        guard let imageUrl = URL(
            string: contact.picture.large
        ) else { return }
        contactImage.af.setImage(withURL: imageUrl)
    }

}
