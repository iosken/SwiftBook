//
//  ViewController.swift
//  SwiftBook
//
//  Created by Yuri on 15.12.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var rgbView: UIView!
    @IBOutlet var redHorisontalSlider: UISlider!
    @IBOutlet var greenHorisontalSlider: UISlider!
    @IBOutlet var blueHorisontalSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func rgbViewSettingUp() {
        rgbView.layer.cornerRadius = 16
        rgbView.backgroundColor = UIColor.init(red: <#T##CGFloat#>, green: <#T##CGFloat#>, blue: <#T##CGFloat#>, alpha: <#T##CGFloat#>)
    }
    
    func slidersSettingUp() {
        
    }
}



