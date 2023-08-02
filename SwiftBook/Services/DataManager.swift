//
//  DataManager.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 02.08.2023.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    
    init() {}
    
    let names = ["Goga", "Sara", "Boris", "Andrew", "Nick"].shuffled()
    let surnames = ["Mironov", "Petrov", "Sidorov", "Ivanov"].shuffled()
    let emails = ["mironov@icloud.com", "petrov@gmail.com", "sidorov@hotmail.com", "ivanov@gmail.com"].shuffled()
    let phones = ["83335557788", "89326782244", "85437843397", "89876543211"].shuffled()
}
