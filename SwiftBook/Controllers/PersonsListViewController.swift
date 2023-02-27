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
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listID", for: indexPath)

        let person = persons[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        
        content.text = person.fullName
        
        cell.contentConfiguration = content
        
        print(indexPath)

        return cell
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
