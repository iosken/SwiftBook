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
    
    // MARK: - Overrided Properties
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }
    
    // MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        rgbView.layer.cornerRadius = 16
    }
    
    // MARK: - IB Actions
    @IBAction func slidersAction(_ sender: UISlider) {
        setupRgbView()
        setupSlidersValuesLabels(sender)
    }
        
    // MARK: - Private Methods
    private func setupRgbView() {
        rgbView.backgroundColor = UIColor(
            red: CGFloat(colorChannelSliders[0].value),
            green: CGFloat(colorChannelSliders[1].value),
            blue: CGFloat(colorChannelSliders[2].value),
            alpha: 1
        )
    }
    
    private func setupSliders() {
        for horisontalSlider in colorChannelSliders {
            horisontalSlider.minimumValue = 0
            horisontalSlider.maximumValue = 1
            horisontalSlider.value = 0
        }
    }
    
    private func setupSlidersValuesLabels(_ currentSlider: UISlider) {
        if let colorSliderIndex = colorChannelSliders.firstIndex(of: currentSlider) {
            slidersValuesLabels[colorSliderIndex].text = String(
                format: "%.2f",
                currentSlider.value
            )
        }
    }
}
