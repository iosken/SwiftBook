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
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var getNewButton: UIButton!
    
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
            if getNewButton.isHidden {
                getNewButton.isHidden.toggle()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
    }
    
    @IBAction func refreshButtonPressed() {
        fetchEmojihub()
    }
    
}

extension EmojihubViewController {
    
    func fetchEmojihub() {
        NetworkManager.shared.fetch(
            dataType: Emojihub.self,
            from: Link.emojihub.rawValue) { [weak self] result in
                switch result {
                case .success(let data):
                    self?.activityIndicator.stopAnimating()
                    self?.emojihub = data
                case .failure(let error):
                    print(error)
                    if let self = self {
                        ShowAlert.shared.showAlert(where: self, status: .failed)
                    }
                }
            }
    }
    
}
