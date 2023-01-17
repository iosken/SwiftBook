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

    var number: Float = 0
    var round = 0
    var points: Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        number = Float.random(in: 0...50)
        label.text = number.formatted()
    }

    @IBAction func checkNumber() {

        round += 1
        
        switch slider.value {
        case number:
            points += 50
        case ..<number:
            points += 50 - slider.value + number
        default:
            points += 50 + slider.value + number
        }
        
        if round == 5 {
            let alert = UIAlertController(
                title: "GREAT!",
                message: "You have \(points) points",
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "Restart", style: .default) {_ in
                self.round = 0
                self.points = 0
                self.number = Float.random(in: 0...50)
                self.label.text = self.number.formatted()
            }
            
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            
            //label.text = points.formatted()
        } else {
            number = Float.random(in: 0...50)
            label.text = number.formatted()
        }
    }
}

