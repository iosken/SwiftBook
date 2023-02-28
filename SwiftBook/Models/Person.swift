//
//  ContactList.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 25.02.2023.
//

import Foundation

struct Person {
    
    let name: String
    let surname: String
    let email: String
    let phoneNumber: String
    
}

extension Person {
    
    var fullName: String {
        name + " " + surname
    }
    
}
