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
    
    // MARK: - Overrided Properties
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }
    
    // MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1450980392, green: 0.2941176471, blue: 0.5764705882, alpha: 1)
        
        rgbView.layer.cornerRadius = 16
        
        slidersValuesTextFields.forEach { textField in
            textField.keyboardType = UIKeyboardType.numberPad
        }
        
        setupLabels()
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
            
            slidersValuesLabels[colorSliderIndex].text = String(
                round(sender.value * 100) / 100
            )
        }
        
        setColor()
    }
    @IBAction func doneButtonPressed() {
        delegate.setColor(from: color)
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
                
                slidersValuesLabels[colorSliderIndex].text = String(
                    round(slider.value * 100) / 100
                )
            }
        }
    }
    
    private func setupLabels() {
        for slidersValuesLabel in slidersValuesLabels {
            slidersValuesLabel.textColor = .white
        }
        
        for slidersColorsNamesLabel in slidersColorsNamesLabels {
            slidersColorsNamesLabel.textColor = .white
        }
    }
}

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

