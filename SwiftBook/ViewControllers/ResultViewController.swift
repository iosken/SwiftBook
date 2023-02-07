//
//  ResultViewController.swift
//  SwiftBook
//
//  Created by Yuri on 02.02.2023.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var resultDescription: UILabel!
    
    var answersChosen: [Answer]!
    
    private var winnersDefinitions: [AnimalType] {
        getWinnersTypes(from: answersChosen)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.setHidesBackButton(true, animated: false)
        
        resultDescription.text = winnersDefinitions.first?.definition
        resultLabel.text = "Вы - \(winnersDefinitions.first?.rawValue ?? "🐙")"
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true)
    }
    
}

private func getWinnersTypes(from answers: [Answer]) -> [AnimalType] {
    var animalTypeChoseCounts: [AnimalType: Int] = [:]
    
    var maxChoseTypes: [AnimalType] = []
    
    for answer in answers {
        animalTypeChoseCounts[answer.type] = (animalTypeChoseCounts[answer.type] ?? 0) + 1
    }
    
    if let maxChosen = animalTypeChoseCounts.values.sorted(by: >).first {
        maxChoseTypes = animalTypeChoseCounts.keysForVlue(value: maxChosen)
    }
    
    return maxChoseTypes
}
