//
//  PersonsListViewController.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 26.02.2023.
//

import UIKit

class PersonsListViewController: UITableViewController {
    
    var persons: [Person] {
        
        var persons: [Person] = []
        
        guard let viewControllers = tabBarController?.viewControllers else { return DataStore().persons }
        
        viewControllers.forEach { viewController in
            if let navigationVC = viewController as? UINavigationController {
                guard let contactListVC = navigationVC.topViewController as? ContactListViewController else { return }
                persons = contactListVC.persons
            }
        }
        
        return persons
    }
    
    // MARK: - Overrided Properties
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }
    
    // MARK: - Table View Data Source
    override func numberOfSections(in tableView: UITableView) -> Int {
        persons.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listID", for: indexPath)
        
        let person = persons[indexPath.section]
        
        var content = cell.defaultContentConfiguration()
        
        if indexPath.row == 0 {
            content.text = person.phoneNumber
            content.image = UIImage(systemName: "phone")
            cell.contentConfiguration = content
        } else {
            content.text = person.email
            content.image = UIImage(systemName: "tray")
            cell.contentConfiguration = content
        }
        
        print(indexPath)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        persons[section].fullName
    }
    
}
