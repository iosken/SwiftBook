//
//  TrafficLights.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 11.07.2023.
//

import Foundation
import SwiftUI

class TrafficLights {
    var lightState: (red: Double, yellow: Double, green: Double) = (0.3, 0.3, 0.3)
    
    var red: Color {
        .red.opacity(lightState.red)
    }
    
    var yellow: Color {
        .yellow.opacity(lightState.yellow)
    }
    
    var green: Color {
        .green.opacity(lightState.green)
    }
    
}
