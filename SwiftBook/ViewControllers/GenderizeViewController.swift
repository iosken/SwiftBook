//
//  GenderizeViewController.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 22.05.2023.
//

import UIKit

class GenderizeViewController: UIViewController {

    @IBOutlet var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func customNameTextField(_ sender: Any) {
        
        
        
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

extension GenderizeViewController {
    
    func fetchGenderize() {
        NetworkManager.shared.fetch(dataType: Genderize.self, from: Link.genderize.rawValue) { [weak self] result in
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
