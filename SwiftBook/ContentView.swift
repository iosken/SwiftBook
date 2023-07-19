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
    
    @State var currentFocus: Color?
    
    private let size = (UIScreen.main.bounds).size.width / 3
    
    var body: some View {
        NavigationView {
            VStack() {
                colorShape(
                    red: redSliderValue,
                    green: greenSliderValue,
                    blue: blueSliderValue
                ).frame(height: size)
                
                KeyboardView {
                    VStack() {
                        ColorSliderView(
                            value: $redSliderValue,
                            currentFocus: $currentFocus,
                            color: .red
                        )
                        ColorSliderView(
                            value: $greenSliderValue,
                            currentFocus: $currentFocus,
                            color: .green
                        )
                        ColorSliderView(
                            value: $blueSliderValue,
                            currentFocus: $currentFocus,
                            color: .blue
                        )
                    }.padding(.horizontal)
                } toolBar: {
                    HStack() {
                        Button(action: upFocus, label: {
                            Text("↑")
                        }).padding(.horizontal)
                        Button(action: downFocus, label: {
                            Text("↓")
                        })
                        Spacer()
                        Button(action: doneAction, label: {
                            Text("Done")
                        })
                    } .padding(.horizontal)
                }
                
            }
            .padding()
            .navigationBarTitle("Colorized app", displayMode: .automatic)
        }
    }
    
    private func upFocus() {
        switch currentFocus {
        case Color.red:
            currentFocus = .blue
        case Color.green:
            currentFocus = .red
        default:
            currentFocus = .green
        }
    }
    
    private func downFocus() {
        switch currentFocus {
        case Color.red:
            currentFocus = .green
        case Color.green:
            currentFocus = .blue
        default:
            currentFocus = .red
        }
    }
    
    private func doneAction() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct colorShape: View {
    var red: Double
    var green: Double
    var blue: Double
    
    var body: some View {
        Rectangle()
            .cornerRadius(20)
            .foregroundColor(
                Color(
                    red: red/255,
                    green: green/255,
                    blue: blue/255
                )
            )
    }
    
}

struct ColorSliderView: View {
    
    @FocusState var focus: Color?
    
    @Binding var value: Double
    @Binding var currentFocus: Color?
    
    let color: Color
    
    @State private var text = ""
    @State private var alertPresented = false
    
    var body: some View {
        HStack {
            Text("\(lround(value))").frame(width: 40)
            
            Slider(value: $value, in: 0...255, step: 1).tint(color)
            
            TextField("\(lround(value))", text: $text, onEditingChanged: checkColorValue)
                .frame(width: 40)
                .keyboardType(.numberPad)
                .focused($focus, equals: color)
                .alert ("Wrong Format", isPresented: $alertPresented) {
                    Text ("Set number of color")
                }
        }
        .onChange(of: currentFocus) { focused in
            focus = currentFocus
        }
        .onTapGesture {
            currentFocus = color
        }
        .onAppear {
            text = String(lround(value))
        }
    }
    
    private func checkColorValue(change: Bool) {
        if let convertedValue = Double(text) {
            value = convertedValue
        } else {
            alertPresented.toggle()
            
            DispatchQueue.main.async {
                text = String(lround(value))
            }
        }
    }
    
}


