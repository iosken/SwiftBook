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
    @IBOutlet var slidersColorsNamesLabels: [UILabel]!
    
    @IBOutlet var slidersValuesTextFields: [UITextField]!
    
    // MARK: - Private Properties
    var delegate: SettingsViewControllerDelegate!
    
    var color: UIColor!
    
    var isDoneButtonPressed = false
    
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
        
        setColor()
    }
    
    // MARK: - IB Actions
    @IBAction func slidersValueChanged(_ sender: UISlider) {
        if let colorSliderIndex = colorChannelSliders.firstIndex(of: sender) {
            switch colorSliderIndex {
            case 0:
                color = UIColor(red: CGFloat(sender.value), green: color.rgba.green, blue: color.rgba.blue, alpha: color.rgba.alpha)
            case 1:
                color = UIColor(red: color.rgba.red, green: CGFloat(sender.value), blue: color.rgba.blue, alpha: color.rgba.alpha)
            default:
                color = UIColor(red: color.rgba.red, green: color.rgba.green, blue: CGFloat(sender.value), alpha: color.rgba.alpha)
            }
        }
        
        setColor()
    }
    
    @IBAction func doneButtonPressed() {
        
        print("doneButtonPressed")
        
        view.endEditing(true)
        
        dismiss(animated: true)
    }
    
    // MARK: - Public Methods
    private func setColor() {
        
        rgbView.backgroundColor = UIColor(
            red: color.rgba.red,
            green: color.rgba.green,
            blue: color.rgba.blue,
            alpha: 1
        )
        
        colorChannelSliders.forEach { slider in
            if let colorSliderIndex = colorChannelSliders.firstIndex(of: slider) {
                switch colorSliderIndex {
                case 0:
                    slider.value = Float(color.rgba.red)
                case 1:
                    slider.value = Float(color.rgba.green)
                default:
                    slider.value = Float(color.rgba.blue)
                }
                
                let sliderValue = String(round(slider.value * 100) / 100)

                slidersValuesLabels[colorSliderIndex].text = sliderValue

                slidersValuesTextFields[colorSliderIndex].text = sliderValue
                
                slidersColorsNamesLabels[colorSliderIndex].text = sliderValue
            }
        }
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
        
        print("END EDITING CALLED")
        
        switch textField {
        case slidersValuesTextFields[0]:
            guard let red_ = CGFloat(string: textField.text ?? "") else { break }
            color = UIColor(red: red_, green: color.rgba.green, blue: color.rgba.blue, alpha: color.rgba.alpha)
        case slidersValuesTextFields[1]:
            guard let green_ = CGFloat(string: textField.text ?? "") else { break }
            color = UIColor(red: color.rgba.red, green: green_, blue: color.rgba.blue, alpha: color.rgba.alpha)
        default:
            guard let blue_ = CGFloat(string: textField.text ?? "") else { break }
            color = UIColor(red: color.rgba.red, green: color.rgba.green, blue: blue_, alpha: color.rgba.alpha)
        }
        
        delegate.setColor(from: color)
        
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
