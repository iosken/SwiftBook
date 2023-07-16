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
        
        VStack(spacing: 40) {
            colorShape(
                red: $redSliderValue,
                green: $greenSliderValue,
                blue: $blueSliderValue
            )
            .frame(height: 200)

            VStack(spacing: 10) {
                ColorSliderView(value: $redSliderValue, color: .red)
                ColorSliderView(value: $greenSliderValue, color: .green)
                ColorSliderView(value: $blueSliderValue, color: .blue)
            }

            Spacer()
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
    @State private var text = ""
    @State private var alertPresented = false
    
    let color: Color
    
    var body: some View {
        HStack {
            Text("\(lround(value))").frame(width: 45)
            Slider(value: $value, in: 0...255, step: 1).tint(color)
            
            TextField("\(lround(value))", text: $text, onEditingChanged: checkColorValue)
                .frame(width: 45)
//                .keyboardType(.numberPad)
            
            
                .alert ("Wrong Format", isPresented: $alertPresented) {
                    Text ("Set number of color")
                }
            
        }
        .onAppear {
            text = String(lround(value))
        }
    }
    
    private func checkColorValue(change: Bool) {
        print("after", text)
        if let convertedValue = Double(text) {
            value = convertedValue
        } else {
            alertPresented.toggle()
            
            DispatchQueue.main.async {
                text = String(lround(value))
            }
            
            print("change", text)
        }
    }
}
