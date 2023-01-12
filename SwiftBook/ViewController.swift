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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.minValue = minValueLabel.text
        settingsVC.maxValue = maxValueLabel.text
    }

    
    @IBAction func getResultButtonTaped(_ sender: UIButton) {
        let minNumber = Int(minValueLabel.text ?? "") ?? 0
        let maxNumber = Int(maxValueLabel.text ?? "") ?? 100
        randomNumberLabel.text = Int.random(in: minNumber...maxNumber).formatted()
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
        guard let settingsVC = segue.source as? SettingsViewController else { return }
        minValueLabel.text = settingsVC.minValueTextField.text
        maxValueLabel.text = settingsVC.maxValueTextField.text
    }
}

