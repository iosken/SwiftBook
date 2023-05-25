//
//  EmojihubViewController.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 22.05.2023.
//

import UIKit

final class EmojihubViewController: UIViewController {
    
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var emojiLabel: UILabel!
    
    private var emojihub: Emojihub? {
        didSet {
            resultLabel.text = emojihub?.description ?? "no data"
            
            emojiLabel.text = emojihub?.emojis
            
            if emojiLabel.isHidden {
                emojiLabel.isHidden.toggle()
            }
            
            if resultLabel.isHidden {
                resultLabel.isHidden.toggle()
            }
        }
    }
    
    @IBAction func refreshButtonPressed() {
        fetchEmojihub()
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

extension EmojihubViewController {
    
    func fetchEmojihub() {
        NetworkManager.shared.fetch(
            dataType: Emojihub.self,
            from: Link.emojihub.rawValue) { [weak self] result in
                switch result {
                case .success(let data):
                    self?.emojihub = data
                case .failure(let error):
                    print(error)
                    self?.showAlert(status: .failed)
                }
            }
    }
    
}
