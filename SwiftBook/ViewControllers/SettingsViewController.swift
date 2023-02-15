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
    
    // MARK: - Private Properties
    var delegate: SettingsViewControllerDelegate!
    
    var color: UIColor!
    
    // MARK: - Overrided Properties
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }
    
    // MARK: - View Lifecycle Methods
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
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
        
        print("doneButtonPressed")
        
        view.endEditing(true)
        
        dismiss(animated: true)
        
    }
    
    // MARK: - Public Methods
    private func setColor(_ sender: Any?) {
        
        var channelIndex: Int?
        
        if let setSender = sender as? UISlider {
            if let colorSliderIndex = colorChannelSliders.firstIndex(
                of: setSender
            ) {
                channelIndex = colorSliderIndex
            }
        } else if let setSender = sender as? UITextField {
            
            if let textFieldIndex = slidersValuesTextFields.firstIndex(
                of: setSender
            ) {
                channelIndex = textFieldIndex
                
                switch channelIndex {
                case 0:
                    guard let red_ = CGFloat(
                        string: setSender.text ?? ""
                    ) else { break }
                    
                    colorChannelSliders[0].value = Float(red_)
                case 1:
                    guard let green_ = CGFloat(
                        string: setSender.text ?? ""
                    ) else { break }
                    
                    colorChannelSliders[1].value = Float(green_)
                default:
                    guard let blue_ = CGFloat(
                        string: setSender.text ?? ""
                    ) else { break }
                    
                    colorChannelSliders[2].value = Float(blue_)
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

extension CGFloat {

    init?(string: String) {

        guard let number = NumberFormatter().number(from: string) else {
            return nil
        }

        self.init(number.floatValue)
    }

}

