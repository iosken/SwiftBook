//
//  UserSettings.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 22.07.2023.
//

import Foundation

final class UserSettings: ObservableObject {
    let data = StorageManager.shared
    
    @Published var isLoggedIn = false
    var name = ""
    
    init() {
        isLoggedIn = data.bool(forKey: .isLoggedIn) ?? false
        name = data.string(forKey: .name) ?? ""
    }

}
