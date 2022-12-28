//
//  ViewController.swift
//  SwiftBook
//
//  Created by Yuri on 15.12.2022.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var redCircleView: UIView!
    @IBOutlet var yellowCircleView: UIView!
    @IBOutlet var greenCircleView: UIView!
    @IBOutlet var startButton: UIButton!
    
    @IBOutlet var mainStacktopConstraint: NSLayoutConstraint!
    @IBOutlet var mainStackBottomConstraint: NSLayoutConstraint!
    @IBOutlet var mainStackAspectConstraint: NSLayoutConstraint!
    
    // MARK: - Public Properties
    let trafficLight = TrafficLight()
    let offLightState = OnOffLightToggle.off
    let onLightState = OnOffLightToggle.on
    
    
    // MARK: - Life Cycles Properties and Methods
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
        
        let mainAspectSizeVertical = 1 / (mainStackAspectConstraint.multiplier)
        let heighOfMainStack = screenBounds - topSafeAreaHeight - bottomSafeAreaHeight - mainStacktopConstraint.constant - mainStackBottomConstraint.constant
        let widthOfMainStack = heighOfMainStack / mainAspectSizeVertical
        let cornerRadiusValue = widthOfMainStack / 2
        
        redCircleView.layer.cornerRadius = cornerRadiusValue
        yellowCircleView.layer.cornerRadius = cornerRadiusValue
        greenCircleView.layer.cornerRadius = cornerRadiusValue
        
        redCircleView.alpha = offLightState.rawValue
        yellowCircleView.alpha = offLightState.rawValue
        greenCircleView.alpha = offLightState.rawValue
        
        startButton.layer.cornerRadius = startButton.frame.width / (64 * mainStackAspectConstraint.multiplier)
    }
    
    // MARK: - Public objects
    enum OnOffLightToggle: CGFloat { //one point to change On Off alpha channel fixed state of Circles
        case off = 0.3
        case on = 1
    }
    
    class TrafficLight {
        var currentState: States?
        
        enum States {
            case red(red: OnOffLightToggle, yellow: OnOffLightToggle, green: OnOffLightToggle)
            case yellow(red: OnOffLightToggle, yellow: OnOffLightToggle, green: OnOffLightToggle)
            case green(red: OnOffLightToggle, yellow: OnOffLightToggle, green: OnOffLightToggle)
        }
        
        func nextState() {
            switch currentState {
            case .red:
                currentState = .yellow(red: .off, yellow: .on, green: .off)
            case .yellow:
                currentState = .green(red: .off, yellow: .off, green: .on)
            case .green:
                currentState = .red(red: .on, yellow: .off, green: .off)
            default:
                currentState = .red(red: .on, yellow: .off, green: .off)
            }
        }
    }
    
    // MARK: - IB Actions
    @IBAction func startNextButtonTapped() {
        trafficLight.nextState()
        
        switch trafficLight.currentState {
        case let .red(red: redValue, yellow: yellowValue, green: greenValue):
            redCircleView.alpha = redValue.rawValue
            yellowCircleView.alpha = yellowValue.rawValue
            greenCircleView.alpha = greenValue.rawValue
        case let .yellow(red: redValue, yellow: yellowValue, green: greenValue):
            redCircleView.alpha = redValue.rawValue
            yellowCircleView.alpha = yellowValue.rawValue
            greenCircleView.alpha = greenValue.rawValue
        case let .green(red: redValue, yellow: yellowValue, green: greenValue):
            redCircleView.alpha = redValue.rawValue
            yellowCircleView.alpha = yellowValue.rawValue
            greenCircleView.alpha = greenValue.rawValue
        default:
            break
        }
    }
}
