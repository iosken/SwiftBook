//
//  TrafficLight.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 10.07.2023.
//

import Foundation
import SwiftUI

// MARK: - Enum TrafficLightsState

private enum TrafficLightsState {
    case red(red: StateValue = .on, yellow: StateValue = .off, green: StateValue = .off)
    case yellow(red: StateValue = .off, yellow: StateValue = .on, green: StateValue = .off)
    case green(red: StateValue = .off, yellow: StateValue = .off, green: StateValue = .on)
    case start(red: StateValue = .off, yellow: StateValue = .off, green: StateValue = .off)
}

extension TrafficLightsState {
    enum StateValue: CGFloat { //one point to change On/Off alpha channel level for circles views
        case off = 0.3
        case on = 1
    }
}

final class TrafficLightsManager {
    
    // MARK: - Public Properties
    
    static let share = TrafficLightsManager()
    
    var red: Color {
        trafficLights.red
    }
    
    var yellow: Color {
        trafficLights.yellow
    }
    
    var green: Color {
        trafficLights.green
    }
    
    // MARK: - Private Properties
    
    private var trafficLights = TrafficLights()
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
            trafficLights.lightsState.red = redValue.rawValue
            trafficLights.lightsState.yellow = yellowValue.rawValue
            trafficLights.lightsState.green = greenValue.rawValue
        case let .red(red: redValue, yellow: yellowValue, green: greenValue):
            trafficLights.lightsState.red = redValue.rawValue
            trafficLights.lightsState.yellow = yellowValue.rawValue
            trafficLights.lightsState.green = greenValue.rawValue
        case let .yellow(red: redValue, yellow: yellowValue, green: greenValue):
            trafficLights.lightsState.red = redValue.rawValue
            trafficLights.lightsState.yellow = yellowValue.rawValue
            trafficLights.lightsState.green = greenValue.rawValue
        case let .green(red: redValue, yellow: yellowValue, green: greenValue):
            trafficLights.lightsState.red = redValue.rawValue
            trafficLights.lightsState.yellow = yellowValue.rawValue
            trafficLights.lightsState.green = greenValue.rawValue
        default:
            trafficLights.lightsState.red = 0
            trafficLights.lightsState.yellow = 0
            trafficLights.lightsState.green = 0
        }
    }
    
}
