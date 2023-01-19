//
//  WelcomeViewController.swift
//  SwiftBook
//
//  Created by Yuri on 08.01.2023.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet var welcomeLabel: UILabel!
    @IBOutlet var smileLabel: UILabel!
    
    var userName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setGradientBackground()
        
        welcomeLabel.text = "Welcome, "// + userName + "!"
        welcomeLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
    }
    
    func setGradientBackground() {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor, #colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1).cgColor, #colorLiteral(red: 0.1089015152, green: 0.04369994437, blue: 0.0011215809, alpha: 1).cgColor, #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 0.25, 0.93, 1]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
