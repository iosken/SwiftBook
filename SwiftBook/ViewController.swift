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
    @IBOutlet var colorNamesLabels: [UILabel]!
    
    // MARK: - Private Properties
    private var viewColor: (red: CGFloat, green: CGFloat , blue: CGFloat) = (0, 0, 0)
    
    // MARK: - Overrided Properties
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }
    
    // MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1450980392, green: 0.2941176471, blue: 0.5764705882, alpha: 1)
        
        rgbViewBaseSettinsUp()
        slidersBaseSettingsUp()
        labelsBaseSettingsUp()
    }
    
    // MARK: - IB Actions
    @IBAction func slidersValueChanged(_ sender: UISlider) {
        if let colorSliderIndex = colorSliders.firstIndex(of: sender) {
            switch colorSliderIndex {
            case 0:
                viewColor.red = CGFloat(sender.value)
                valueLabels[colorSliderIndex].text = String(
                    round(sender.value * 100) / 100
                )
            case 1:
                viewColor.green = CGFloat(sender.value)
                valueLabels[colorSliderIndex].text = String(
                    round(sender.value * 100) / 100
                )
            default:
                viewColor.blue = CGFloat(sender.value)
                valueLabels[colorSliderIndex].text = String(
                    round(sender.value * 100) / 100
                )
            }
        }
        rgbView.backgroundColor = UIColor(
            red: viewColor.red,
            green: viewColor.green,
            blue: viewColor.blue,
            alpha: 1
        )
    }
    
    // MARK: - Public Methods
    private func rgbViewBaseSettinsUp() {
        rgbView.layer.cornerRadius = 16
        rgbView.backgroundColor = UIColor.init(
            red: viewColor.red,
            green: viewColor.green,
            blue: viewColor.blue,
            alpha: 1
        )
    }
    
    private func slidersBaseSettingsUp() {
        for horisontalSlider in colorSliders {
            horisontalSlider.minimumValue = 0
            horisontalSlider.maximumValue = 1
            horisontalSlider.value = 0
        }
    }
    
    private func labelsBaseSettingsUp() {
        for valueLabel in valueLabels {
            valueLabel.textColor = .white
        }
        for colorNamesLabel in colorNamesLabels {
            colorNamesLabel.textColor = .white
        }
    }
}
