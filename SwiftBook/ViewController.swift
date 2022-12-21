//
//  ViewController.swift
//  SwiftBook
//
//  Created by Yuri on 15.12.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var redCircleView: UIView!
    @IBOutlet var yellowCircleView: UIView!
    @IBOutlet var greenCircleView: UIView!
    @IBOutlet var startNextColorLightButton: UIButton!
       
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// hide objects to sneak transform:
        redCircleView.alpha = 0
        yellowCircleView.alpha = 0
        greenCircleView.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        redCircleView.layer.cornerRadius = redCircleView.frame.width / 2
        yellowCircleView.layer.cornerRadius = yellowCircleView.frame.width / 2
        greenCircleView.layer.cornerRadius = greenCircleView.frame.width / 2
        
        ///immediately show objects after transformation(with hometask start a-level):
        redCircleView.alpha = 0.3
        yellowCircleView.alpha = 0.3
        greenCircleView.alpha = 0.3
    }
    
    @IBAction func startNextColorLightButtonTapped() {
        if redCircleView.alpha < 1 && yellowCircleView.alpha < 1 && greenCircleView.alpha < 1 {
            startNextColorLightButton.setTitle("Next", for: .normal)
        }
    }
    
    
}
