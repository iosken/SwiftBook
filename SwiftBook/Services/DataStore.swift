//
//  DataStore.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 25.02.2023.
//

import Foundation

class DataStore {
    private var names = ["John", "George", "Nikolai", "Stephan", "Peter", "Sharon", "Aaron"]
    
    private var surnames = ["Zik", "Solovei", "Baks", "One", "Two", "Thousand", "Jankin"]
    
    private var emails = ["aaaa@mail.ru", "bbbbb@mail.ru", "ccccc@mail.ru", "dddd@mail.ru", "eeeee@mail.ru", "fffff@mail.ru", "ggggg@mail.ru"]
    
    private var phones = ["435352426", "4353465365", "2342354363", "3242342532", "3245425452", "3242353436534", "324354645645"]
    
    lazy var persons: [Person] = getPersons()
}

extension DataStore {
    
    var namesCount: Int {
        names.count
    }
    
    var getName: String {
        guard !names.isEmpty else { return ""}
        
        let index = (0..<names.count).randomElement() ?? 0
        let name = names[index]
        
        names.remove(at: index)
        
        return name
    }
    
    var getSurname: String {
        guard !surnames.isEmpty else { return ""}
        
        let index = (0..<surnames.count).randomElement() ?? 0
        let surname = surnames[index]
        
        surnames.remove(at: index)
        
        return surname
    }
    
    var getEmail: String {
        guard !emails.isEmpty else { return ""}
        
        let index = (0..<emails.count).randomElement() ?? 0
        let email = emails[index]
        
        emails.remove(at: index)
        
        return email
    }
    
    var getPhone: String {
        guard !phones.isEmpty else { return ""}
        
        let index = (0..<phones.count).randomElement() ?? 0
        let phone = phones[index]
        
        phones.remove(at: index)
        
        return phone
    }
    
}

extension DataStore {
    func getPersons() -> [Person] {
        var persons: [Person] = []
        
        var person: Person {
            Person(
                name: getName,
                surname: getSurname,
                email: getEmail,
                phoneNumber: getPhone
            )
        }
        
        repeat {
            persons.append(person)
        } while namesCount != 0
        
        return persons
    }
}
