//
//  ShowPropertiesViewController.swift
//  SwiftBook
//
//  Created by Yuri on 26.01.2023.
//

import UIKit

class ShowPropertiesViewController: UIViewController {
    
    @IBOutlet var propertieValueTextField: UITextField!
    @IBOutlet var userPropertiesSelector: UISlider!
    
    var userProperties: UserProperties!
    var userPropertiesValues = [""]
    var propertyIndex = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.layer.insertSublayer(
            UIViewController.gradientLayer(bounds: self.view.bounds),
            at: 0
        )
        
        userPropertiesValues = userProperties.values()
        userPropertiesSelector.maximumValue = Float(userPropertiesValues.count - 1)
        userPropertiesSelector.value = Float(propertyIndex)
        
        propertieValueTextField.text = userPropertiesValues[propertyIndex]
    }
    
    
    @IBAction func userPropertiesSelection(_ sender: Any) {
        guard propertyIndex != Int(userPropertiesSelector.value.rounded()) else { return }
        
        propertyIndex = Int(userPropertiesSelector.value.rounded())
        
        propertieValueTextField.text = userPropertiesValues[propertyIndex]
    }
    
}


