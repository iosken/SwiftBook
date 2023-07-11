//
//  ContentView.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 08.07.2023.
//

import SwiftUI

struct ContentView: View {
    private let lights = TrafficLightsManager.share
    private let size = (UIScreen.main.bounds).size.width / 3
    
    @State private var redCircle: Color = .red
    @State private var yellowCircle: Color = .yellow
    @State private var greenCircle: Color = .green
    @State private var currentStateName = "Start"
    
    var body: some View {
        VStack() {
            VStack(spacing: 30) {
                Circle()
                    .foregroundColor(redCircle)
                    .frame(width: size, height: size)
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
                Circle()
                    .foregroundColor(yellowCircle)
                    .frame(width: size, height: size)
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
                Circle()
                    .foregroundColor(greenCircle)
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
            
            redCircle = lights.red
            yellowCircle = lights.yellow
            greenCircle = lights.green
        }
    }
    
    private func changeStates() {
        lights.nextState()
        
        redCircle = lights.red
        yellowCircle = lights.yellow
        greenCircle = lights.green
        
        currentStateName = "Next"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




