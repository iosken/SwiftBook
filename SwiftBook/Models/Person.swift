//
//  Person.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 02.08.2023.
//

import Foundation

struct Person: Identifiable {
    var id: UUID
    let name: String
    let surname: String
    let email: String
    let phone: String
}

extension Person {
    static func newPerson() -> Person {
        let data = DataManager.shared
        
        return Person (
            id: UUID(),
            name: data.names.randomElement() ?? "",
            surname: data.surnames.randomElement() ?? "",
            email: data.emails.randomElement() ?? "",
            phone: data.phones.randomElement() ?? ""
        )
    }
    
    static func generateContacts(count: Int) -> [Person] {
        var result: [Person] = []
        for _ in 1...count {
            result.append(newPerson())
        }
        return result
    }
}
