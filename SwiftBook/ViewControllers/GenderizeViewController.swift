//
//  GenderizeViewController.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 22.05.2023.
//

import UIKit

final class GenderizeViewController: UIViewController {
    
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var nameTextField: UITextField!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
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

extension GenderizeViewController {
    
    func fetchGenderize() {
        guard let text = nameTextField.text else { return }
        let link = Link.genderize(from: text)
        
        NetworkManager.shared.fetch(dataType: Genderize.self, from: link) { [weak self] result in
            switch result {
            case .success(let data):
                self?.resultLabel.text = data.description
            case .failure(let error):
                print(error)
                self?.showAlert(status: .failed)
            }
        }
    }
    
}

extension GenderizeViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        (nameTextField.text ?? "").forEach { char in
            let symbol = String(char)
            if Int(symbol) != nil {
                showAlert(status: .nothing)
                nameTextField.text? = "Scott"
                return
            }
        }
        
        if !(nameTextField.text?.isEmpty ?? true) {
            fetchGenderize()
        } else {
            showAlert(status: .nothing)
            nameTextField.text? = "Scott"
        }
        
        fetchGenderize()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (nameTextField.text?.count ?? 0) > 16 {
            showAlert(status: .nothing)
            nameTextField.text?.removeLast()
            return false
        }
        return true
    }
    
}


