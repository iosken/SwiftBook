//
//  DataManager.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 02.08.2023.
//

import Foundation

final class DataManager {
    static let shared = DataManager()
    
    let names = ["Peter", "Axe", "Boris", "Andrew", "Nick"]
    let surnames = ["Mironov", "Petrov", "Sidorov", "Ivanov", "Gavrilov"]
    let emails = ["topProjectManager@icloud.com", "topFinEngineer@gmail.com", "topManager@hotmail.com", "topDesigner@gmail.com", "topProgrammer"]
    let phones = ["83335557788", "89326782244", "85437843397", "89876543211", "82345679988"]
    
    init() {}
}
