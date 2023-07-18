//
//  ContentView.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 08.07.2023.
//

import SwiftUI

enum ColorState: Hashable {
    case red
    case green
    case blue
}

struct ContentView: View {
    
    
    
    @State private var redSliderValue = Double.random(in: 0...255)
    @State private var greenSliderValue = Double.random(in: 0...255)
    @State private var blueSliderValue = Double.random(in: 0...255)
    
    @State var currentFocus: ColorState?
    
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
                        ColorSliderView(value: $redSliderValue, currentFocus: $currentFocus, color: .red, colorSlider: .red)
                        ColorSliderView(value: $greenSliderValue, currentFocus: $currentFocus, color: .green, colorSlider: .green)
                        ColorSliderView(value: $blueSliderValue, currentFocus: $currentFocus, color: .blue, colorSlider: .blue)
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
        switch currentFocus {
        case .red:
            currentFocus = .blue
        case .green:
            currentFocus = .red
        case .blue:
            currentFocus = .green
        default:
            return
        }
    }
    
    private func downFocus() {
        
        switch currentFocus {
        case .red:
            currentFocus = .green
        case .green:
            currentFocus = .blue
        case .blue:
            currentFocus = .red
        default:
            return
        }
        
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
    @FocusState var focus: ColorState?
    
    @Binding var value: Double
    @Binding var currentFocus: ColorState?
    
    @State private var text = ""
    @State private var alertPresented = false
    
    let color: Color
    let colorSlider: ColorState
    
    var body: some View {
        HStack {
            Text("\(lround(value))").frame(width: 40)
            
            Slider(value: $value, in: 0...255, step: 1).tint(color)
            
            TextField("\(lround(value))", text: $text, onEditingChanged: checkColorValue)
                .frame(width: 40)
                .keyboardType(.numberPad)
                .focused($focus, equals: colorSlider)
                .alert ("Wrong Format", isPresented: $alertPresented) {
                    Text ("Set number of color")
                }
        }
        .onChange(of: currentFocus) { focused in
            focus = currentFocus
        }
        .onTapGesture {
            currentFocus = colorSlider
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
    
    private func cancelFucus() {
        focus = nil
    }
    

}

//public extension View {
//    func storeLastFocus<Value: Hashable>(current: FocusState<Value?>.Binding, last: Binding<Value?>) -> some View {
//        onChange(of: current.wrappedValue) { _ in
//            if current.wrappedValue != last.wrappedValue {
//                last.wrappedValue = current.wrappedValue
//            }
//        }
//    }
//
//    func focused<Value>(_ binding: FocusState<Value>.Binding, equals value: Value, last: Value?, onFocus: @escaping (Bool) -> Void) -> some View where Value: Hashable {
//        return focused(binding, equals: value)
//            .onChange(of: binding.wrappedValue) { focusValue in
//                if focusValue == value {
//                    onFocus(true)
//                } else if last == value { // only call once
//                    onFocus(false)
//                }
//            }
//    }
//}


