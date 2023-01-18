//
//  ViewController.swift
//  SwiftBook
//
//  Created by Yuri on 15.12.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var slider: UISlider!
    @IBOutlet var label: UILabel!

    var game: Game!
      
    lazy var secondViewControler = getSecondViewController()
    
    private func getSecondViewController() -> SecondViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "SecondViewController")
        return viewController as! SecondViewController
    }
    
    override func loadView() {
        super.loadView()
        print("loadView")
        
        let versionLabel = UILabel(frame: CGRect(x: 20, y: 10, width: 200, height: 20))
        versionLabel.text = "Version 1.1"
        versionLabel.textColor = .systemGray
        self.view.addSubview(versionLabel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        game = Game(startValue: 1, endValue: 50, rounds: 5)
    
        label.text = game.currentSecretValue.formatted()
    }
    
    @IBAction func showNextScreen() {
        self.present(secondViewControler, animated: true, completion: nil)
    }

    @IBAction func checkNumber() {

        game.calculateScore(with: Int(slider.value))
        
        if game.isGameEnded {
            showAlertWith(score: game.score)
            game.restartGame()
        } else {
            game.startNewRound()
        }
        
        label.text = game.currentSecretValue.formatted()
        
    }
    
    private func showAlertWith(score: Int) {
        let alert = UIAlertController(
            title: "GREAT!",
            message: "You have \(score) points",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "Restart", style: .default) {_ in
            
        }
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

