//
//  ContactListAddViewController.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 07.06.2023.
//

import UIKit

final class ContactListAddViewController: UITableViewController {
    
    private var contacts: [ContactShort] = []
    private let storageManager = StorageManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contacts = storageManager.fetchContacts()
    }
    
    // MARK: - UITAbleViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Contact", for: indexPath)
        let contact = contacts[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = contact.fullName
        cell.contentConfiguration = content
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let newContactVC = segue.destination as? ContactAddNewViewController else { return }
        newContactVC.delegate = self
    }
    
}

// MARK: - UITableViewDelegate

extension ContactListAddViewController {
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            storageManager.deleteContact(at: indexPath.row)
            contacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

// MARK: - NewContactViewControllerDelegate
@available(iOS 16.0, *)
extension ContactListAddViewController: ContactAddNewViewControllerDelegate {
    func add(contact: ContactShort) {
        contacts.append(contact)
        tableView.reloadData()
    }
}
