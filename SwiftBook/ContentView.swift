//
//  ContentView.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 08.07.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var redSliderValue = Double.random(in: 0...255)
    @State private var greenSliderValue = Double.random(in: 0...255)
    @State private var blueSliderValue = Double.random(in: 0...255)
    private var color: Color {
        Color(
            red: redSliderValue/255,
            green: greenSliderValue/255,
            blue: blueSliderValue/255
        )
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                colorShape(
                    red: $redSliderValue,
                    green: $greenSliderValue,
                    blue: $blueSliderValue
                )
                ColorSliderView(value: $redSliderValue, color: .red)
                ColorSliderView(value: $greenSliderValue, color: .green)
                ColorSliderView(value: $blueSliderValue, color: .blue)
                Text("\(redSliderValue) \(greenSliderValue) \(blueSliderValue)")
                Spacer(minLength: 350)
            }
        }
        .padding()
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct colorShape: View {
    @Binding var red: Double
    @Binding var green: Double
    @Binding var blue: Double
    
    var body: some View {
        Rectangle()
            .cornerRadius(20)
            .foregroundColor(Color(
                red: red/255,
                green: green/255,
                blue: blue/255
            ))
    }
    
}

struct ColorSliderView: View {
    @Binding var value: Double
    let color: Color
    
    var body: some View {
        HStack {
            Text("0")
            Slider(value: $value, in: 0...255, step: 1)
                .tint(color)
         
            Text("255")
        }
    }
}
