//
//  TrafficLights.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 11.07.2023.
//

import Foundation
import SwiftUI

class TrafficLights {
    var lightsState: (red: Double, yellow: Double, green: Double) = (0, 0, 0)
    
    var red: Color {
        .red.opacity(lightsState.red)
    }
    
    var yellow: Color {
        .yellow.opacity(lightsState.yellow)
    }
    
    var green: Color {
        .green.opacity(lightsState.green)
    }
    
}
