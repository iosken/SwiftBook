//
//  WallstreetbetViewController.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 24.05.2023.
//

import UIKit

final class WallstreetbetListViewController: UITableViewController {
    
    private var counter = 0
    private var bets: [Wallstreetbet] = []
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bets.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BetTableViewCell", for: indexPath)
        
        var configuration = cell.defaultContentConfiguration()
        configuration.text = bets[indexPath.row].description
        
        if bets.isEmpty{
            let indicator = UIActivityIndicatorView()
            indicator.startAnimating()
            cell.addSubview(indicator)
        }

        cell.contentConfiguration = configuration
        
        return cell
    }
    
}

extension WallstreetbetListViewController {
    
    func fetchWallstreetbet() {
//        NetworkManager.shared.fetchData(type: Wallstreetbet.self, from: Link.wallstreetbet.url) { [weak self] result in
//            switch result {
//            case .success(let bets):
//                self?.bets = bets
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    }
//    func fetchWallstreetbet() {
//        NetworkManager.shared.fetch(
//            dataType: [Wallstreetbet].self,
//            from: Link.wallstreetbet.rawValue) { [weak self] result in
//                switch result {
//                case .success(let data):
//                    self?.bets = data
//                    DispatchQueue.main.async {
//                        self?.tableView.reloadData()
//                    }
//                case .failure(let error):
//                    if let self = self {
//                        ShowAlert.shared.showAlert(where: self, status: .failed)
//                    }
//                    print(error)
//                }
//            }
//    }
    
}
