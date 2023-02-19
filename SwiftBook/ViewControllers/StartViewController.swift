//
//  StartViewController.swift
//  SwiftBook
//
//  Created by Yuri on 09.02.2023.
//

import UIKit

protocol SettingsViewControllerDelegate {
    /// Main color
    func setColor(from color: UIColor)
}

class StartViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.color = view.backgroundColor
        settingsVC.delegate = self
    }
    
}

// MARK: - SettingsViewControllerDelegate
extension StartViewController: SettingsViewControllerDelegate {
    func setColor(from color: UIColor) {
        view.backgroundColor = color
    }
}
