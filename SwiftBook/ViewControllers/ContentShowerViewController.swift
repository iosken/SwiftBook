//
//  ContentShowerViewController.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 19.05.2023.
//

import UIKit

enum UserAction: String, CaseIterable {
    case emojihub = "Show Emoji!"
    case genderize = "Tell about Name"
    case swapi = "Description of Planet"
    case wallstreetbet = "Some info about wallstreetbet"
}

class ContentShowerViewController: UITableViewController {
    
    let userActions = UserAction.allCases

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return userActions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        var configuration = cell.defaultContentConfiguration()
        
        configuration.text = userActions[indexPath.row].rawValue
        configuration.image = UIImage(named: "content")
        
        cell.contentConfiguration = configuration

        return cell
    }
    
    // MARK: - Table view delegate
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
//    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        
    }

}
