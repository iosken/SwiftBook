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
    
    private let networkManager = NetworkManager.shared
    
    private var emojihub: Emoji? {
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
    
    func fetchEmojihub() {
        networkManager.fetchData(type: Emoji.self, from: Link.emojihub.url) { [weak self] result in
            switch result {
            case .success(let emojihub):
                self?.emojihub = emojihub
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
