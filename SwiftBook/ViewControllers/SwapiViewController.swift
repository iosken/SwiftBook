//
//  SWAPIViewController.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 22.05.2023.
//

import UIKit

final class SwapiViewController: UIViewController {
    
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var planetNameTextField: UITextField!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    var planets: [Planet] = []
    var names: [String] = []
    var planetIndex = 0
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        activityIndicator.startAnimating()
        
        let elementPicker = UIPickerView()
        elementPicker.delegate = self
        
        planetNameTextField.inputView = elementPicker
        planetNameTextField.delegate = self
    }
    
    // MARK: - Private Methods
    
    private func showAlert(status: StatusAlert) {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: status.title,
                message: status.message,
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
    
}

extension SwapiViewController {
    
    func fetchSwapi() {
        NetworkManager.shared.fetch(
            dataType: Swapi.self,
            from: Link.swapi.rawValue) { [weak self] result in
                switch result {
                case .success(let data):
                    self?.activityIndicator.stopAnimating()
                    self?.planets = data.results
                    self?.names = data.names
                case .failure(let error):
                    print(error)
                    self?.showAlert(status: .failed)
                    DispatchQueue.main.async {
                        self?.planetNameTextField.isEnabled = false
                        self?.planetNameTextField.text = "No data to chose"
                    }
                    
                }
            }
    }

}

// MARK: - UIPickerViewDataSource and UIPickerViewDelegate

extension SwapiViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        planets.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        planets[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        planetNameTextField.text = planets[row].name
        planetIndex = row
    }
    
}

// MARK: - UITextFieldDelegate

extension SwapiViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        var description = planets[planetIndex].description
        
        if names.contains(planetNameTextField.text ?? "") {
            planetIndex = names.firstIndex(of: planetNameTextField.text ?? "") ?? 0
            description = planets[planetIndex].description
        } else {
            planetNameTextField.text = names[planetIndex]
        }
        
        resultLabel.text = description
        planetNameTextField.text = planets[planetIndex].name
        
        if resultLabel.isHidden {
            resultLabel.isHidden.toggle()
        }
    }
}
