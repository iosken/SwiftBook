//
//  ContentView.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 08.07.2023.
//


import SwiftUI

struct ContentView: View {
    @State private var value: Float = 0.0
    @State private var targetValue: Float = 50.0
    @State private var opacity: Float = 1.0
    @State private var alertPresented: Bool = false
    
    private var result: String {
        round(opacity * 100).formatted()
    }
    
    private var computeScore: Float {
        let difference = abs(targetValue - value)
        
        return (100 - difference) / 100
    }
    
    private let size = (UIScreen.main.bounds).size.width - 100
    
    var body: some View {
        VStack {
            Text("Подвиньте слайдер как можно ближе к \(round(targetValue).formatted())")
            
            HStack {
                Text("0")
                SliderView(value: $value, opacity: $opacity)
                    .frame(width: size)
                    .onChange(of: value) { newValue in
                        opacity = computeScore
                    }
                Text("100")
            }
            
            Button(action: { alertPresented.toggle() }) {
                Text("Проверь меня!")
            }
            .padding()
            .alert("Результат", isPresented: $alertPresented, actions: {}) {
                Text("Ваш результат \(result)")
            }
            
            Button(action: gameBegin) {
                Text("Начать заново")
            }
        }
        .padding()
        .onAppear {
            gameBegin()
            opacity = computeScore
        }
    }
    
    private func gameBegin() {
        targetValue = round(Float.random(in: 0...100) * 100) / 100
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
