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
        
        let indexRandom = Int.random(in: 0..<data.emails.count)
        
        return Person (
            id: UUID(),
            name: data.names[indexRandom],
            surname: data.surnames[indexRandom],
            email: data.emails[indexRandom],
            phone: data.phones[indexRandom]
        )
    }
    
    static func generateContacts() -> [Person] {
        let data = DataManager.shared
        var result: [Person] = []
        
        let names = data.names.shuffled()
        let surnames = data.surnames.shuffled()
        let emails = data.emails.shuffled()
        let phones = data.phones.shuffled()
        
        for index in 0..<data.names.count {
            result.append(Person(
                id: UUID(),
                name: names[index],
                surname: surnames[index],
                email: emails[index],
                phone: phones[index]
            )
            )
        }
        
        return result
    }
}
