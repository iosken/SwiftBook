//
//  SWAPIViewController.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 22.05.2023.
//

import UIKit

class SWAPIViewController: UIViewController {

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


extension SWAPIViewController {
    
    func fetchSwapi() {
        NetworkManager.shared.fetch(dataType: SWAPI.self, from: Link.swapi.rawValue) { [weak self] result in
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
