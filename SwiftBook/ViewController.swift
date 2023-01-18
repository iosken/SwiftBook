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
        
        number = Float.random(in: 0...50)
        label.text = number.formatted()
        print("viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDissapear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear")
    }
    
    @IBAction func showNextScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let viewController = storyboard.instantiateViewController(identifier: "SecondViewController") as! SecondViewController
        
        self.present(viewController, animated: true, completion: nil)
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

