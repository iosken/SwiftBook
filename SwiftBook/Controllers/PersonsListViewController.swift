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
    
    override func loadView() {
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        print("This 2")
        return persons.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listID", for: indexPath)

        let person = persons[indexPath.section]
        let name = person.fullName
        let phone = person.phoneNumber
        let email = person.email
        
        var content = cell.defaultContentConfiguration()
        
        switch indexPath.row {
        case 0:
            content.text = person.phoneNumber
            cell.contentConfiguration = content
        default:
            content.text = person.email
            cell.contentConfiguration = content
        }
        
        print(indexPath)

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        persons[section].fullName
    }
    
    
    // MARK: Table View Delegate
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
