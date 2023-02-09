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
    
    @IBOutlet var colorChannelSliders: [UISlider]!
    
    @IBOutlet var slidersValuesLabels: [UILabel]!
    @IBOutlet var slidersColorsNamesLabels: [UILabel]!
    
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
        
        rgbView.layer.cornerRadius = 16
        
        setupLabels()
        setupRgbView()
    }
    
    // MARK: - IB Actions
    @IBAction func slidersValueChanged(_ sender: UISlider) {
        if let colorSliderIndex = colorChannelSliders.firstIndex(of: sender) {
            switch colorSliderIndex {
            case 0:
                viewColor.red = CGFloat(sender.value)
            case 1:
                viewColor.green = CGFloat(sender.value)
            default:
                viewColor.blue = CGFloat(sender.value)
            }
            
            slidersValuesLabels[colorSliderIndex].text = String(
                round(sender.value * 100) / 100
            )
        }
        
        setupRgbView()
    }
    
    // MARK: - Public Methods
    private func setupRgbView() {
        rgbView.backgroundColor = UIColor(
            red: viewColor.red,
            green: viewColor.green,
            blue: viewColor.blue,
            alpha: 1
        )
    }
    
    private func setupLabels() {
        for slidersValuesLabel in slidersValuesLabels {
            slidersValuesLabel.textColor = .white
        }
        
        for slidersColorsNamesLabel in slidersColorsNamesLabels {
            slidersColorsNamesLabel.textColor = .white
        }
    }
    
    //private func
}

