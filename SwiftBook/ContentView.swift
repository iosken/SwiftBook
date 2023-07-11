//
//  ContentView.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 08.07.2023.
//

import SwiftUI

struct ContentView: View {
    
    private let lights = TrafficLightsManager.share
    private let trafficLight = TrafficLights()
    private let size = (UIScreen.main.bounds).size.width / 3
    
    @State private var redCircleAlpha = 0.3
    @State private var yellowCircleAlpha = 0.3
    @State private var greenCircleAlpha = 0.3
    @State private var currentStateName = "Start"
    
    var body: some View {
        VStack() {
            VStack(spacing: 30) {
                Circle()
                    .foregroundColor(.red.opacity(redCircleAlpha))
                    .frame(width: size, height: size)
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
                Circle()
                    .foregroundColor(.yellow.opacity(yellowCircleAlpha))
                    .frame(width: size, height: size)
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
                Circle()
                    .foregroundColor(.green.opacity(greenCircleAlpha))
                    .frame(width: size, height: size)
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
            }
            .padding(size / 4)
            
            Spacer()
            
            Button(action: { changeStates() }) {
                Text(currentStateName)
                    .font(.title)
            }
            .padding(size / 4)
        }

        .onAppear {
            lights.nextState()
        }
        
        
    }
    
    private func changeStates() {
        lights.nextState()
        
        redCircleAlpha = lights.currentStateValue.red
        yellowCircleAlpha = lights.currentStateValue.yellow
        greenCircleAlpha = lights.currentStateValue.green
        
        currentStateName = "Next"
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




