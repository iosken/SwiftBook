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
    @IBOutlet var startButton: UIButton!
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// hide objects to sneak transform:
        redCircleView.alpha = 0
        yellowCircleView.alpha = 0
        greenCircleView.alpha = 0
        startButton.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        redCircleView.layer.cornerRadius = redCircleView.frame.width / 2
        yellowCircleView.layer.cornerRadius = yellowCircleView.frame.width / 2
        greenCircleView.layer.cornerRadius = greenCircleView.frame.width / 2
        
        startButton.layer.cornerRadius = startButton.frame.width / 16
        
        ///show objects after transformation:
        redCircleView.alpha = 0.3
        yellowCircleView.alpha = 0.3
        greenCircleView.alpha = 0.3
        startButton.alpha = 1
    }
    
    @IBAction func startNextColorLightButtonTapped() {
        if startButton.currentTitle != "NEXT" {
            startButton.setTitle("NEXT", for: .normal)
            redCircleView.alpha = 1
            return
        }
        
        if redCircleView.alpha == 1 {
            redCircleView.alpha = 0.3
            yellowCircleView.alpha = 1
        } else if yellowCircleView.alpha == 1 {
            yellowCircleView.alpha = 0.3
            greenCircleView.alpha = 1
        } else {
            greenCircleView.alpha = 0.3
            redCircleView.alpha = 1
        }
    }
    
    
}
