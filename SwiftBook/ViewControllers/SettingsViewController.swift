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
    
//    var colorSet: (red: CGFloat?, green: CGFloat?, blue: CGFloat?) {
//        get {
//            (red: color.rgba.red, green: color.rgba.green, blue: color.rgba.blue)
//            }
//        set {
//            color = UIColor(
//                red: CGFloat(newValue.red ?? color.rgba.red),
//                green: CGFloat(newValue.green ?? color.rgba.green),
//                blue: CGFloat(newValue.blue ?? color.rgba.blue),
//                alpha: color.rgba.alpha
//                )
//            }
//        }
    
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
                
                switch channelIndex {
                case 0:
                    color = UIColor(
                        red: CGFloat(setSender.value),
                        green: color.rgba.green,
                        blue: color.rgba.blue,
                        alpha: color.rgba.alpha
                    )
                case 1:
                    color = UIColor(
                        red: color.rgba.red,
                        green: CGFloat(setSender.value),
                        blue: color.rgba.blue,
                        alpha: color.rgba.alpha
                    )
                default:
                    color = UIColor(
                        red: color.rgba.red,
                        green: color.rgba.green,
                        blue: CGFloat(setSender.value),
                        alpha: color.rgba.alpha
                    )
                }
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
                    
                    color = UIColor(
                        red: red_,
                        green: color.rgba.green,
                        blue: color.rgba.blue,
                        alpha: color.rgba.alpha
                    )
                    
                    colorChannelSliders[channelIndex ?? 0].value = Float(red_)
                case 1:
                    guard let green_ = CGFloat(
                        string: setSender.text ?? ""
                    ) else { break }
                    
                    color = UIColor(
                        red: color.rgba.red,
                        green: green_,
                        blue: color.rgba.blue,
                        alpha: color.rgba.alpha
                    )
                    
                    colorChannelSliders[channelIndex ?? 0].value = Float(green_)
                default:
                    guard let blue_ = CGFloat(
                        string: setSender.text ?? ""
                    ) else { break }
                    
                    color = UIColor(
                        red: color.rgba.red,
                        green: color.rgba.green,
                        blue: blue_,
                        alpha: color.rgba.alpha
                    )
                    
                    colorChannelSliders[channelIndex ?? 0].value = Float(blue_)
                }
            }
            
            if let channelIndex = channelIndex {
                
                let stringValue = String(
                    round(colorChannelSliders[channelIndex].value * 100) / 100
                )
                
                slidersValuesLabels[channelIndex].text = stringValue
                
                slidersValuesTextFields[channelIndex].text = stringValue
                
                slidersColorsNamesLabels[channelIndex].text = stringValue
            } else {
                
                for channelIndex in colorChannelSliders.indices {
                    
                    
                    //colorChannelSliders[channelIndex].value =
                    
                    let stringValue = String(
                        round(colorChannelSliders[channelIndex].value * 100) / 100
                    )
                    
                    slidersValuesLabels[channelIndex].text = stringValue
                    
                    slidersValuesTextFields[channelIndex].text = stringValue
                    
                    slidersColorsNamesLabels[channelIndex].text = stringValue
                }
            }
            

        }
        
        rgbView.backgroundColor = UIColor(
            red: color.rgba.red,
            green: color.rgba.green,
            blue: color.rgba.blue,
            alpha: 1
        )
        
        delegate.setColor(from: color)
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
    
    
//        subscript(channel: Int) -> CGFloat {
//            get {
//                switch channel {
//                case 0:
//                    return rgba.red
//                case 1:
//                    return rgba.green
//                default:
//                    return rgba.blue
//                }
//            }
//
//            set {
//                switch channel {
//                case 0:
//                    self.cgColor = UIColor(red: newValue, green: self.rgba.green, blue: self.rgba.blue, alpha: self.rgba.alpha) as! CGColor
//                case 1:
//                    UIColor(red: newValue, green: self.rgba.green, blue: self.rgba.blue, alpha: self.rgba.alpha)
//                default:
//                    UIColor(red: newValue, green: self.rgba.green, blue: self.rgba.blue, alpha: self.rgba.alpha)
//                }
//            }
//        }
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

