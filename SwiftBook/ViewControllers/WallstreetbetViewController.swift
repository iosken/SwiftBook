//
//  WallstreetbetViewController.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 22.05.2023.
//

import UIKit

class WallstreetbetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

extension WallstreetbetViewController {
    
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
