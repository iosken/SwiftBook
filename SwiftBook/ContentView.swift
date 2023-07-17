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
    
    @State var redFocused = false
    @State var greenFocused = false
    @State var blueFocused = false
    
    private let size = (UIScreen.main.bounds).size.width / 3
    
    private var color: Color {
        Color(
            red: redSliderValue/255,
            green: greenSliderValue/255,
            blue: blueSliderValue/255
        )
    }
    
    var body: some View {
        NavigationView {
            VStack() {
                colorShape(
                    red: $redSliderValue,
                    green: $greenSliderValue,
                    blue: $blueSliderValue
                ).frame(height: size)
                
                KeyboardView {
                    VStack() {
                        ColorSliderView(value: $redSliderValue, isFocused: $redFocused, color: .red)
                        ColorSliderView(value: $greenSliderValue, isFocused: $greenFocused, color: .green)
                        ColorSliderView(value: $blueSliderValue, isFocused: $blueFocused, color: .blue)
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
                        Button(action: {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }, label: {
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
        switch true {
        case redFocused:
            redFocused = false
            blueFocused = true
        case greenFocused:
            greenFocused = false
            redFocused = true
        default:
            blueFocused = false
            greenFocused = true
        }
        
//        if redFocused {
//            redFocused = false
//            blueFocused = true
//        } else if greenFocused {
//            greenFocused = false
//            redFocused = true
//        } else {
//            blueFocused = false
//            greenFocused = true
//        }
    }
    
    private func downFocus() {
        switch true {
        case redFocused:
            redFocused = false
            greenFocused = true
        case greenFocused:
            greenFocused = false
            blueFocused = true
        default:
            blueFocused = false
            redFocused = true
        }
        
//        if redFocused {
//            redFocused = false
//            greenFocused = true
//        } else if greenFocused {
//            greenFocused = false
//            blueFocused = true
//        } else {
//            blueFocused = false
//            redFocused = true
//        }
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
    @Binding var isFocused: Bool
    
    @FocusState var focus: Bool
    
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
                .focused($focus)
                .alert ("Wrong Format", isPresented: $alertPresented) {
                    Text ("Set number of color")
                }
        }
        .onChange(of: isFocused) { focused in
            focus = focused
        }
        .onTapGesture {
            focus = false
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


