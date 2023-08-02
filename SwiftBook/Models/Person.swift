//
//  Person.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 02.08.2023.
//

import Foundation

struct Person {
    let name: String
    let surname: String
    let email: String
    let phone: String
}

extension Person {
    func newPerson() -> Person {
        let data = DataManager.shared
        
        return Person (
            name: data.names.randomElement() ?? "",
            surname: data.surnames.randomElement() ?? "",
            email: data.emails.randomElement() ?? "",
            phone: data.phones.randomElement() ?? ""
        )
    }
}
