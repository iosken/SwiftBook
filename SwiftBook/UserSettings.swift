//
//  UserSettings.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 22.07.2023.
//

import Foundation

final class UserSettings: ObservableObject {
    @Published var isLoggedIn = false
    var name = ""
}
