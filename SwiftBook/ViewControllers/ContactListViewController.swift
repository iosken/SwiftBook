//
//  ContactListViewController.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 01.06.2023.
//

import UIKit
import Alamofire

class ContactListViewController: UITableViewController {
    
    private var contacts: [Contact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 60
        
        setupRefreshControl()
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(contacts.count)
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactListCell", for: indexPath)
        
        var configuration = cell.defaultContentConfiguration()
        
        configuration.imageProperties.maximumSize = CGSize(width: 100, height: 100)
        configuration.imageProperties.cornerRadius = 50
        
        let contact = contacts[indexPath.row]
        configuration.text = contact.name.first
        configuration.secondaryText = contact.name.last
        
        NetworkManager.shared.fetchData(fromData: URL(string: contact.picture.thumbnail)) { result in
            switch result {
            case .success(let data):
                configuration.image = UIImage(data: data)
                cell.contentConfiguration = configuration
            case .failure(let error):
                print(error)
            }
        }
        
        cell.contentConfiguration = configuration
        
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let contactDetailVC = segue.destination as? ContactDetailViewController else { return }
        
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        contactDetailVC.contact = contacts[indexPath.row]
        
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        
        let refreshAction = UIAction { [weak self] _ in
            self?.fetch()
        }
        
        refreshControl?.addTarget(self, action: #selector(fetch), for: .valueChanged)
    }
}

extension ContactListViewController {
    @objc func fetch() {
        NetworkManager.shared.fetchData(type: Contact.self, fromJson: Link.contacts.url) { [weak self] result in
            switch result {
            case .success(let contacts):
                if self?.refreshControl != nil {
                    self?.refreshControl?.endRefreshing()
                }
                self?.contacts = contacts
                self?.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
                AlertManager.shared.showAlert(from: self, status: .failed)
            }
        }
    }
}

