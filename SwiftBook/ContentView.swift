//
//  ContentView.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 08.07.2023.
//

import SwiftUI

struct ContentView: View {
    let size = 
    
    var body: some View {
        VStack(spacing: 30) {
            Circle()
                .foregroundColor(.red)
                .frame(width: 150, height: 150)
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
            Circle()
                .foregroundColor(.red)
                .frame(width: 150, height: 150)
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
            Circle()
                .foregroundColor(.red)
                .frame(width: 150, height: 150)
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
