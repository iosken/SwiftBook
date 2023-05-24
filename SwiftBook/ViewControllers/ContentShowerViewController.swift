//
//  ContentShowerViewController.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 19.05.2023.
//

import UIKit

private enum UserAction: String, CaseIterable {
    case emojihub = "Show Emoji!"
    case genderize = "Tell about Name"
    case swapi = "Description of Planet"
    case wallstreetbet = "Some info about wallstreetbet"
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
        case .emojihub: performSegue(withIdentifier: "emojihub", sender: nil)
        case .genderize: performSegue(withIdentifier: "genderize", sender: nil)
        case .swapi: performSegue(withIdentifier: "swapi", sender: nil)
        case .wallstreetbet: performSegue(withIdentifier: "wallstreetbet", sender: nil)
        }
        
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //    guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        switch segue.identifier {
        case "emojihub":
            guard let emojihubVC = segue.destination as? EmojihubViewController else { return }
            emojihubVC.fetchEmojihub()
        case "genderize":
            guard let genderizeVC = segue.destination as? GenderizeViewController else { return }
        case "swapi":
            guard let swapiVC = segue.destination as? SWAPIViewController else { return }
        default:
            guard let wallstreetbetVC = segue.destination as? WallstreetbetViewController else { return }
            
        }

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
