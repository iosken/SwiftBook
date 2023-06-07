//
//  ContactAddNewViewController.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 07.06.2023.
//

import UIKit

protocol ContactAddNewViewControllerDelegate {
    func add(contact: ContactAdd)
}

@available(iOS 16.0, *)
final class ContactAddNewViewController: UIViewController {

    @IBOutlet var doneButton: UIBarButtonItem!
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    
    var delegate: ContactAddNewViewControllerDelegate!
    
    private let storageManager = StorageManager.shared
        
    override func viewDidLoad() {
        super.viewDidLoad()
        let action = UIAction { [weak self] _ in
            guard let firstName = self?.firstNameTextField.text else { return }
            self?.doneButton.isEnabled = !firstName.isEmpty
        }
        firstNameTextField.addAction(action, for: .editingChanged)
    }
    
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        save()
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    private func save() {
        guard let firstName = firstNameTextField.text else { return }
        guard let lastName = lastNameTextField.text else { return }
        let contact = ContactAdd(firstName: firstName, lastName: lastName)
        storageManager.save(contact: contact)
        delegate.add(contact: contact)
        dismiss(animated: true)
    }
}
