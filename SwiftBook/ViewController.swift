//
//  ViewController.swift
//  SwiftBook
//
//  Created by Yuri on 15.12.2022.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - IB Outlets
    @IBOutlet var rgbView: UIView!
    @IBOutlet var colorSliders: [UISlider]!
    @IBOutlet var valueLabels: [UILabel]!
    
    // MARK: - Public Properties
    private var viewColor: (red: CGFloat, green: CGFloat , blue: CGFloat ) = (0, 0, 0)
    
    // MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slidersSettingUp()
        rgbViewSettingUp()
    }
    
    // MARK: - IB Actions
    @IBAction func slidersValueChanged(_ sender: UISlider) {
        for colorSlider in colorSliders.enumerated() where colorSlider.element == sender {
            switch colorSlider.offset {
            case 0:
                viewColor.red = CGFloat(sender.value)
                valueLabels[colorSlider.offset].text = String(round(sender.value * 100) / 100)
            case 1:
                viewColor.green = CGFloat(sender.value)
                valueLabels[colorSlider.offset].text = String(round(sender.value * 100) / 100)
            default:
                viewColor.blue = CGFloat(sender.value)
                valueLabels[colorSlider.offset].text = String(round(sender.value * 100) / 100)
            }
        }
        
        rgbView.backgroundColor = UIColor(red: viewColor.red, green: viewColor.green, blue: viewColor.blue, alpha: 1)
    }
    
    // MARK: - Public Methods
    func rgbViewSettingUp() {
        rgbView.layer.cornerRadius = 16
        rgbView.backgroundColor = UIColor.init(
            red: viewColor.red,
            green: viewColor.green,
            blue: viewColor.blue,
            alpha: 1
        )
    }
    
    func slidersSettingUp() {
        for horisontalSlider in colorSliders.enumerated() {
            horisontalSlider.element.maximumValue = 0
            horisontalSlider.element.maximumValue = 1
            horisontalSlider.element.value = 0
        }
    }
}



