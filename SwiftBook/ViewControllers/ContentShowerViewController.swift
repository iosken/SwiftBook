//
//  ContentShowerViewController.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 19.05.2023.
//

import UIKit

private enum ID: String {
    
    case emojihub = "emojihub"
    case genderize = "genderize"
    case swapi = "swapi"
    case wallstreetbet = "wallstreetbet"
    
}

private enum UserAction: String, CaseIterable {
    
    case emojihub = "Emoji randomizer"
    case genderize = "Genderize"
    case swapi = "StarWars Planets"
    case wallstreetbet = "Wallstreet Bets List"
    
}

final class ContentShowerViewController: UITableViewController {
    
    private let userActions = UserAction.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userActions.count
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.item]
        
        switch userAction {
        case .emojihub: performSegue(withIdentifier: ID.emojihub.rawValue, sender: nil)
        case .genderize: performSegue(withIdentifier: ID.genderize.rawValue, sender: nil)
        case .swapi: performSegue(withIdentifier: ID.swapi.rawValue, sender: nil)
        case .wallstreetbet: performSegue(withIdentifier: ID.wallstreetbet.rawValue, sender: nil)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case ID.emojihub.rawValue:
            guard let emojihubVC = segue.destination as? EmojihubViewController else { return }
            emojihubVC.fetchEmojihub()
        case ID.genderize.rawValue:
            guard let genderizeVC = segue.destination as? GenderizeViewController else { return }
            genderizeVC.fetchGenderize()
        case ID.swapi.rawValue:
            guard let swapiVC = segue.destination as? SwapiViewController else { return }
            swapiVC.fetchSwapi()
        default:
            guard let wallstreetbetVC = segue.destination as? WallstreetbetListViewController else { return }
            wallstreetbetVC.fetchWallstreetbet()
            
        }
    }
    
}
