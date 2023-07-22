//
//  RootView.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 22.07.2023.
//

import SwiftUI

struct RootView: View {
    @StateObject private var userSettings = UserSettings()
    
    @AppStorage("name") static var storageName = ""
    @AppStorage("isLoggedIn") static var storageIsLoggedIn = false
    
    var body: some View {
        Group {
            if userSettings.isLoggedIn {
                ContentView()
            } else {
                LoginView()
            }
        }
        .environmentObject(userSettings)
        .onAppear() {
            userSettings.name = RootView.storageName
            userSettings.isLoggedIn = RootView.storageIsLoggedIn
        }
    }
    
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
