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
    
    @IBOutlet var mainStacktopConstraint: NSLayoutConstraint!
    @IBOutlet var mainStackBottomConstraint: NSLayoutConstraint!
    @IBOutlet var mainStackAspectConstraint: NSLayoutConstraint!
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var topSafeAreaHeight: CGFloat = 0
        var bottomSafeAreaHeight: CGFloat = 0
        let screenBounds = (UIScreen.main.bounds).size.height
        
        if #available(iOS 11.0, *) {
            let scenes = UIApplication.shared.connectedScenes
            let windowScene = scenes.first as? UIWindowScene
            let window = windowScene?.windows.first
            let safeFrame = window?.safeAreaLayoutGuide.layoutFrame
            
            topSafeAreaHeight = safeFrame?.minY ?? 0
            bottomSafeAreaHeight = (window?.frame.maxY ?? 0) - (safeFrame?.maxY ?? 0)
            // topSafeAreaHeight and bottomSafeAreaHeight is now available
        }
        
        let mainAspectSizeVertical = 10 / (mainStackAspectConstraint.multiplier * 10)
        let heighOfMainStack = screenBounds - topSafeAreaHeight - bottomSafeAreaHeight - mainStacktopConstraint.constant - mainStackBottomConstraint.constant
        let widthOfMainStack = heighOfMainStack / mainAspectSizeVertical
        let cornerRadiusValue = widthOfMainStack / 2
        
        redCircleView.layer.cornerRadius = cornerRadiusValue
        yellowCircleView.layer.cornerRadius = cornerRadiusValue
        greenCircleView.layer.cornerRadius = cornerRadiusValue
        
        startButton.layer.cornerRadius = startButton.frame.width / (64 * mainStackAspectConstraint.multiplier)
        
        redCircleView.alpha = 0.3
        yellowCircleView.alpha = 0.3
        greenCircleView.alpha = 0.3
    }
    
    class TrafficLight {
        var currentState: States?
        
        enum States {
            case red
            case yellow
            case green
        }
        
        func nextState() {
            switch currentState {
            case .red:
                currentState = .yellow
            case .yellow:
                currentState = .green
            case .green:
                currentState = .red
            default:
                currentState = .red
            }
        }
    }
    
    let trafficLight = TrafficLight()
    
    @IBAction func startNextColorLightButtonTapped() {
        if trafficLight.currentState == .green || trafficLight.currentState == nil {
            greenCircleView.alpha = 0.3
            redCircleView.alpha = 1
        } else if trafficLight.currentState == .red {
            redCircleView.alpha = 0.3
            yellowCircleView.alpha = 1
        } else {
            yellowCircleView.alpha = 0.3
            greenCircleView.alpha = 1
        }
        trafficLight.nextState()
    }
}
