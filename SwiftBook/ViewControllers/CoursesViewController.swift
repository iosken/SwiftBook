//
//  CoursesViewController.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 11.05.2023.
//

import UIKit

class CoursesViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

}

// MARK: - Networking
extension CoursesViewController {
    func fetchCourses() {
        
    }

}
