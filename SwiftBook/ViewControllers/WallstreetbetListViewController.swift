//
//  WallstreetbetViewController.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 24.05.2023.
//

import UIKit

class WallstreetbetListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BetTableViewCell", for: indexPath)

        let configuration = cell.defaultContentConfiguration()
        
      //  confi

        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Private Methods
    private func showAlert(status: StatusAlert) {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: status.title,
                message: status.message,
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }

}

extension WallstreetbetListViewController {
    
    func fetchWallstreetbet() {
        NetworkManager.shared.fetch(dataType: [Wallstreetbet].self, from: Link.wallstreetbet.rawValue) { [weak self] result in
            switch result {
            case .success(let data):
                print(data)
                self?.showAlert(status: .success)
            case .failure(let error):
                print(error)
                self?.showAlert(status: .failed)
            }
        }
    }
    
}
