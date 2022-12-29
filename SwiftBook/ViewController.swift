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
    
    @IBOutlet var mainStackTopConstraint: NSLayoutConstraint!
    @IBOutlet var mainStackBottomConstraint: NSLayoutConstraint!
    @IBOutlet var mainStackAspectConstraint: NSLayoutConstraint!
    
    // MARK: - Public Properties
    let trafficLight = TrafficLight()
    
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
        
        let heighOfMainStack = screenBounds - topSafeAreaHeight - bottomSafeAreaHeight - mainStackTopConstraint.constant - mainStackBottomConstraint.constant
        let mainStackAspectMultiplierDevider = 1 / (mainStackAspectConstraint.multiplier)
        let widthOfMainStack = heighOfMainStack / mainStackAspectMultiplierDevider
        let cornerRadiusValue = widthOfMainStack / 2
        
        redCircleView.layer.cornerRadius = cornerRadiusValue
        yellowCircleView.layer.cornerRadius = cornerRadiusValue
        greenCircleView.layer.cornerRadius = cornerRadiusValue
        
        trafficLight.redCircleView = redCircleView
        trafficLight.yellowCircleView = yellowCircleView
        trafficLight.greenCircleView = greenCircleView
        trafficLight.nextState()
        
        startButton.layer.cornerRadius = startButton.frame.width / (64 * mainStackAspectConstraint.multiplier)
    }
    
    // MARK: - Public objects
    
    enum TrafficLightsStates {
        case red(red: OnOffLightToggle = .on, yellow: OnOffLightToggle = .off, green: OnOffLightToggle = .off)
        case yellow(red: OnOffLightToggle = .off, yellow: OnOffLightToggle = .on, green: OnOffLightToggle = .off)
        case green(red: OnOffLightToggle = .off, yellow: OnOffLightToggle = .off, green: OnOffLightToggle = .on)
        case start(red: OnOffLightToggle = .off, yellow: OnOffLightToggle = .off, green: OnOffLightToggle = .off)
        
        enum OnOffLightToggle: CGFloat { //one point to change On/Off alpha channel level for circles views
            case off = 0.3
            case on = 1
        }
    }
    
    class TrafficLight {
        var redCircleView: UIView?
        var yellowCircleView: UIView?
        var greenCircleView: UIView?
        
        private var currentState: TrafficLightsStates?
        
        func nextState() {
            switch currentState {
            case .start:
                currentState = .red()
                setToCircles()
            case .red:
                currentState = .yellow()
                setToCircles()
            case .yellow:
                currentState = .green()
                setToCircles()
            case .green:
                currentState = .red()
                setToCircles()
            default:
                currentState = .start()
                setToCircles()
            }
        }
        
        private func setToCircles() {
            switch currentState {
            case let .start(red: redValue, yellow: yellowValue, green: greenValue):
                redCircleView?.alpha = redValue.rawValue
                yellowCircleView?.alpha = yellowValue.rawValue
                greenCircleView?.alpha = greenValue.rawValue
            case let .red(red: redValue, yellow: yellowValue, green: greenValue):
                redCircleView?.alpha = redValue.rawValue
                yellowCircleView?.alpha = yellowValue.rawValue
                greenCircleView?.alpha = greenValue.rawValue
            case let .yellow(red: redValue, yellow: yellowValue, green: greenValue):
                redCircleView?.alpha = redValue.rawValue
                yellowCircleView?.alpha = yellowValue.rawValue
                greenCircleView?.alpha = greenValue.rawValue
            case let .green(red: redValue, yellow: yellowValue, green: greenValue):
                redCircleView?.alpha = redValue.rawValue
                yellowCircleView?.alpha = yellowValue.rawValue
                greenCircleView?.alpha = greenValue.rawValue
            default:
                break
            }
        }
    }
    
    // MARK: - IB Actions
    @IBAction func startNextButtonTapped() {
        if startButton.currentTitle != "NEXT" {
            startButton.setTitle("NEXT", for: .normal)
        }
        trafficLight.nextState()
    }
}
