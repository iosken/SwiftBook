//
//  GenderizeViewController.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 22.05.2023.
//

import UIKit

final class GenderizeViewController: UIViewController {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var resultLabel: UILabel!
    
    private var name = "Scott" {
        didSet {
            nameTextField.text = name
            
            if nameTextField.isHidden {
                nameTextField.isHidden.toggle()
            }
        }
    }
    
    private var descriptionName = "" {
        didSet {
            resultLabel.text = descriptionName
            
            if resultLabel.isHidden {
                resultLabel.isHidden.toggle()
            }
        }
    }
    
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
        NetworkManager.shared.fetch(
            dataType: Genderize.self,
            from: Link.genderize(from: name)) { [weak self] result in
                switch result {
                case .success(let data):
                    self?.name = data.name
                    self?.descriptionName = data.description
                    
                case .failure(let error):
                    print(error)
                    self?.showAlert(status: .failed)
                }
            }
    }
    
}

extension GenderizeViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (24...).contains(nameTextField.text?.count ?? 0) {
            nameTextField.text?.removeLast()
            return false
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        (nameTextField.text ?? "").forEach { char in
            let symbol = String(char)
            if Int(symbol) != nil {
                showAlert(status: .nothing)
                nameTextField.text? = name
                return
            }
        }
        
        if !(nameTextField.text?.isEmpty ?? true) {
            name = nameTextField.text ?? name
            fetchGenderize()
        } else {
            nameTextField.text? = name
            return
        }
        
        fetchGenderize()
    }
    
}


