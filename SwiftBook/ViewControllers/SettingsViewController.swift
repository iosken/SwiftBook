//
//  ViewController.swift
//  SwiftBook
//
//  Created by Yuri on 15.12.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    // MARK: - IB Outlets
    @IBOutlet var rgbView: UIView!
    
    @IBOutlet var colorChannelSliders: [UISlider]!
    
    @IBOutlet var slidersValuesLabels: [UILabel]!
    
    @IBOutlet var slidersValuesTextFields: [UITextField]!
    
    // MARK: - Properties
    var delegate: SettingsViewControllerDelegate!
    
    var color: UIColor!
    
    // MARK: - Overrided Properties and Methods
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rgbView.layer.cornerRadius = 16
        
        addDoneButtonOnKeyboard()
        
        setColor(nil)
    }
    
    // MARK: - IB Actions
    @IBAction func slidersValueChanged(_ sender: UISlider) {
        setColor(sender)
    }
    
    @IBAction func doneButtonPressed() {
        
        view.endEditing(true)
        
        dismiss(animated: true)
        
    }
    
    // MARK: - Main setColor method
    private func setColor(_ sender: Any?) {
        
        var channelIndex: Int? // let returns "Constant 'channelIndex' used before being initialized"
        
        if let sender = sender as? UISlider {
            if let colorSliderIndex = colorChannelSliders.firstIndex(
                of: sender
            ) {
                channelIndex = colorSliderIndex
            }
        } else if let sender = sender as? UITextField {
            
            if let textFieldIndex = slidersValuesTextFields.firstIndex(
                of: sender
            ) {
                channelIndex = textFieldIndex
                
                switch channelIndex {
                case 0:
                    guard let red = CGFloat(
                        string: sender.text ?? ""
                    ) else { break }
                    
                    colorChannelSliders[0].setValue(Float(red), animated: true)
                case 1:
                    guard let green = CGFloat(
                        string: sender.text ?? ""
                    ) else { break }
                    
                    colorChannelSliders[1].setValue(Float(green), animated: true)
                default:
                    guard let blue = CGFloat(
                        string: sender.text ?? ""
                    ) else { break }
                    
                    colorChannelSliders[2].setValue(Float(blue), animated: true)
                }
            }
            
        }
        
        if let channelIndex = channelIndex {
            
            let stringValue = String(
                round(colorChannelSliders[channelIndex].value * 100) / 100
            )
            
            slidersValuesLabels[channelIndex].text = stringValue
            
            slidersValuesTextFields[channelIndex].text = stringValue
            
        } else {
            
            for channelIndex in colorChannelSliders.indices {
                
                switch channelIndex {
                case 0:
                    colorChannelSliders[0].value = Float(color.rgba.red)
                case 1:
                    colorChannelSliders[1].value = Float(color.rgba.green)
                default:
                    colorChannelSliders[2].value = Float(color.rgba.blue)
                }
                
                let stringValue = String(
                    round(colorChannelSliders[channelIndex].value * 100) / 100
                )
                
                slidersValuesLabels[channelIndex].text = stringValue
                
                slidersValuesTextFields[channelIndex].text = stringValue
                
            }
            
        }
        
        rgbView.backgroundColor = UIColor(
            red: CGFloat(colorChannelSliders[0].value),
            green: CGFloat(colorChannelSliders[1].value),
            blue: CGFloat(colorChannelSliders[2].value),
            alpha: 1
        )
        
        delegate.setColor(from: rgbView.backgroundColor ?? UIColor.white)
    }
    
}

// MARK: - Delegatges

extension SettingsViewController: UITextFieldDelegate {
    
    func addDoneButtonOnKeyboard() {
        
        let keyboardToolbar = UIToolbar()
        
        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneButtonPressed)
        )
        
        keyboardToolbar.sizeToFit()
        keyboardToolbar.items = [flexibleSpace, doneButton]
        
        slidersValuesTextFields.forEach { textField in
            
            textField.inputAccessoryView = keyboardToolbar
            
            textField.delegate = self
            
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        setColor(textField)
    }
    
}


// MARK: - Extensions
extension UIColor {
    
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return (red, green, blue, alpha)
    }
    
}

extension CGFloat {
    
    init?(string: String) {
        
        guard let number = NumberFormatter().number(from: string) else {
            return nil
        }
        
        self.init(number.floatValue)
    }
    
}

