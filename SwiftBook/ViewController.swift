//
//  ViewController.swift
//  SwiftBook
//
//  Created by Yuri on 15.12.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var randomNumberLabel: UILabel!
    @IBOutlet var minValueLabel: UILabel!
    @IBOutlet var maxValueLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getResultButtonTaped(_ sender: UIButton) {
        let minNumber = Int(minValueLabel.text ?? "") ?? 0
        let maxNumber = Int(maxValueLabel.text ?? "") ?? 100
        randomNumberLabel.text = Int.random(in: minNumber...maxNumber).formatted()
    }
    
}

