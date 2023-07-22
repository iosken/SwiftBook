//
//  LoginView.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 22.07.2023.
//

import SwiftUI
import Combine

struct LoginView: View {
    @EnvironmentObject private var userSettings: UserSettings
    
    @State private var name = ""
    @State private var accept = false
    @State private var color = Color.red
    
    let data = StorageManager.shared
    
    var body: some View {
        VStack {
            HStack {
                TextField("Enter your name", text: $name)
                    .onReceive(Just(name)) { _ in
                        checkValidation()
                    }
                    .multilineTextAlignment(.center)
                    .padding(.leading, 60)
                Text(name.count.formatted())
                    .foregroundColor($color.wrappedValue)
                    .padding(.trailing, 50)
                    
            }
            
            Button(action: login) {
                HStack {
                    Image(systemName: "checkmark.circle")
                    Text("Ok")
                }
            }
            .disabled(!$accept.wrappedValue)
        }
    }
    
    private func login() {
        if accept {
            userSettings.name = name
            userSettings.isLoggedIn = true
            
            data.set(userSettings.isLoggedIn, forKey: .isLoggedIn)
            data.set(userSettings.name, forKey: .name)
        }
    }
    
    private func checkValidation() {
        if (4...20).contains(name.count) {
            color = .green
            accept = true
        } else {
            if color != .red {
                color = .red
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
