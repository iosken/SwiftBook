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
    
    @IBOutlet var topConstraint: NSLayoutConstraint!
    @IBOutlet var bottomConstraint: NSLayoutConstraint!
    
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
        
//        stackOfCirclesAndButton.topAnchor.constraint(equalTo: stackOfCirclesAndButton.bottomAnchor, constant: 10)
//        redCircleView.layer.cornerRadius = ((UIScreen.main.bounds).size.width / 5 - stackOfCirclesAndButton.topAnchor)
        
//        print((UIApplication.shared.windows.first)?.safeAreaInsets.top)
     //   print((UIWindowScene.windows.first)?.safeAreaInsets.top)
//        
//        print(view.safeAreaLayoutGuide)
//        print((view.safeAreaLayoutGuide).layoutFrame.size.height)
        
        redCircleView.layer.cornerRadius = (((UIScreen.main.bounds).size.height - topConstraint.constant - bottomConstraint.constant) / 5) / 2
        yellowCircleView.layer.cornerRadius = (((UIScreen.main.bounds).size.height - topConstraint.constant - bottomConstraint.constant) / 5) / 2
        greenCircleView.layer.cornerRadius = (((UIScreen.main.bounds).size.height - topConstraint.constant - bottomConstraint.constant) / 5) / 2
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        

        
        startButton.layer.cornerRadius = startButton.frame.width / 16
        
        ///show objects after transformation:
        redCircleView.alpha = 0.3
        yellowCircleView.alpha = 0.3
        greenCircleView.alpha = 0.3
        startButton.alpha = 1
    }
    
    @IBAction func startNextColorLightButtonTapped() {
        guard startButton.currentTitle == "NEXT" else {
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
