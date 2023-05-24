//
//  WallstreetbetViewController.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 24.05.2023.
//

import UIKit

class WallstreetbetListViewController: UITableViewController {
    
    var counter = 0
    
    var bets: [Wallstreetbet] = []
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bets.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BetTableViewCell", for: indexPath)
        
        var configuration = cell.defaultContentConfiguration()
        configuration.text = bets[indexPath.row].description
        cell.contentConfiguration = configuration
        
        return cell
    }
    
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
    
    //    func fetchWallstreetbet() {
    //        NetworkManager.shared.fetch(dataType: [Wallstreetbet].self, from: Link.wallstreetbet.rawValue) {
    //            [weak self] result in
    //            switch result {
    //            case .success(let data):
    //                self?.bets = data
    //            case .failure(let error):
    //                print(error)
    //                self?.showAlert(status: .failed)
    //            }
    //        }
    //    }
    func fetchWallstreetbet() {
        NetworkManager.shared.fetch(dataType: [Wallstreetbet].self, from: Link.wallstreetbet.rawValue) { [weak self] result in
            switch result {
            case .success(let data):
                self?.bets = data
                self?.tableView.reloadData()
            case .failure(let error):
                self?.showAlert(status: .failed)
                
                print(error)
            }
        }
    }
    
}
