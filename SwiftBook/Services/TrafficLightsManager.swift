//
//  TrafficLight.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 10.07.2023.
//

import Foundation
import SwiftUI

private enum TrafficLightsState {
    
    case red(red: StateValue = .on, yellow: StateValue = .off, green: StateValue = .off)
    case yellow(red: StateValue = .off, yellow: StateValue = .on, green: StateValue = .off)
    case green(red: StateValue = .off, yellow: StateValue = .off, green: StateValue = .on)
    case start(red: StateValue = .off, yellow: StateValue = .off, green: StateValue = .off)
    
}

final class TrafficLightsManager {
    
    static let share = TrafficLightsManager()
    
    var currentStateValue: (red: Double, yellow: Double, green: Double) = (0.3, 0.3, 0.3)
    //let trafficLights = TrafficLights()
    
    // MARK: - Private Properties
    
    private var currentState: TrafficLightsState?
    
    private init() {}
    
    // MARK: - Pubic Methods
    
    func nextState() {
        switch currentState {
        case .start:
            currentState = .red()
        case .red:
            currentState = .yellow()
        case .yellow:
            currentState = .green()
        case .green:
            currentState = .red()
        default:
            currentState = .start()
        }
        setToCircles()
    }
    
    // MARK: - Private Methods
    
    private func setToCircles() {
        switch currentState {
        case let .start(red: redValue, yellow: yellowValue, green: greenValue):
            currentStateValue.red = redValue.rawValue
            currentStateValue.yellow = yellowValue.rawValue
            currentStateValue.green = greenValue.rawValue
        case let .red(red: redValue, yellow: yellowValue, green: greenValue):
            currentStateValue.red = redValue.rawValue
            currentStateValue.yellow = yellowValue.rawValue
            currentStateValue.green = greenValue.rawValue
        case let .yellow(red: redValue, yellow: yellowValue, green: greenValue):
            currentStateValue.red = redValue.rawValue
            currentStateValue.yellow = yellowValue.rawValue
            currentStateValue.green = greenValue.rawValue
        case let .green(red: redValue, yellow: yellowValue, green: greenValue):
            currentStateValue.red = redValue.rawValue
            currentStateValue.yellow = yellowValue.rawValue
            currentStateValue.green = greenValue.rawValue
        default:
            currentStateValue.red = 0
            currentStateValue.yellow = 0
            currentStateValue.green = 0
        }
    }
    
}

extension TrafficLightsState {
    enum StateValue: CGFloat { //one point to change On/Off alpha channel level for circles views
        case off = 0.3
        case on = 1
    }
}

