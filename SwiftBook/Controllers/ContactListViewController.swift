//
//  ContactListViewController.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 25.02.2023.
//

import UIKit

class ContactListViewController: UITableViewController {
    
    let dataStore = DataStore()
    
    var persons: [Person] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        persons = dataStore.persons
    }

    // MARK: - Table View data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personID", for: indexPath)
        
        let person = persons[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        
        content.text = person.fullName
        
        cell.contentConfiguration = content

        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("WORKED")
    }


}
