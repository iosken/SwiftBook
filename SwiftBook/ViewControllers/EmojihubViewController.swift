//
//  EmojihubViewController.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 22.05.2023.
//

import UIKit
import SpringAnimation

final class EmojihubViewController: UIViewController {
    
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var emojiLabel: SpringLabel!
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
        activityIndicator.startAnimating()
        fetchEmojihub()
    }
    
    func fetchEmojihub() {
        networkManager.fetchData(type: Emoji.self, from: Link.emojihub.url) { [weak self] result in
            switch result {
            case .success(let emojihub):
                self?.activityIndicator.stopAnimating()
                self?.emojihub = emojihub
                self?.animate()
            case .failure(let error):
                print(error.localizedDescription)
                AlertManager.shared.showAlert(from: self, status: .failed)
            }
        }
    }
    
}

// MARK: Smile Animation

extension EmojihubViewController {
    
    func animate() {
        
        let nextAnimation = randomPreset()
        
        emojiLabel.animation = nextAnimation.animation
        emojiLabel.curve = nextAnimation.curve
        emojiLabel.force = nextAnimation.force
        emojiLabel.duration = nextAnimation.duration
        emojiLabel.delay = nextAnimation.delay
        emojiLabel.animate()
        
    }
    
    func randomPreset() -> (animation: String, curve: String, force: CGFloat, duration: CGFloat, delay: CGFloat) {
        var animations = AnimationPreset.allCases
        
        if let fadeOutIndex = AnimationPreset.allCases.firstIndex(of: AnimationPreset.fadeOut) {
            animations.remove(at: fadeOutIndex)
        }
        if let zoomOutIndex = AnimationPreset.allCases.firstIndex(of: AnimationPreset.zoomOut) {
            animations.remove(at: zoomOutIndex)
        }
        
        if let fallIndex = AnimationPreset.allCases.firstIndex(of: AnimationPreset.fall) {
            animations.remove(at: fallIndex)
        }
        
        let curves = AnimationCurve.allCases
        
        var force: CGFloat {
            CGFloat.random(in: 1...2)
        }
        
        var duration: CGFloat {
            CGFloat.random(in: 0.5...2)
        }
        
        var delay: CGFloat {
            CGFloat.random(in: 0...1)
        }
        
        return (animation: animations.randomElement()?.rawValue ?? "", curve: curves.randomElement()?.rawValue ?? "", force: force, duration: duration, delay: delay)
    }
    
}
