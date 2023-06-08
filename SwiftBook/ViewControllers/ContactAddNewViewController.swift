//
//  ContactAddNewViewController.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 07.06.2023.
//

import UIKit

protocol ContactAddNewViewControllerDelegate {
    func add(contact: ContactShort)
}

final class ContactAddNewViewController: UIViewController {

    @IBOutlet var doneButton: UIBarButtonItem!
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    
    var delegate: ContactAddNewViewControllerDelegate!
    
    private let storageManager = StorageManager.shared
        
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameTextField.addTarget(
            self,
            action: #selector(firstNameTextFieldDidChanged),
            for: .editingChanged
        )
    }
    
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        save()
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @objc private func firstNameTextFieldDidChanged() {
        guard let firstName = firstNameTextField.text else { return }
        doneButton.isEnabled = !firstName.isEmpty
    }
    
    private func save() {
        guard let firstName = firstNameTextField.text else { return }
        guard let lastName = lastNameTextField.text else { return }
        let contact = ContactShort(firstName: firstName, lastName: lastName)
        storageManager.save(contact: contact)
        delegate.add(contact: contact)
        dismiss(animated: true)
    }
}
