//
//  WelcomeModel.swift
//  SwiftBook
//
//  Created by Yuri on 12.01.2023.
//

var autorizationBase: [String: String] = [:]

struct User {
    var userName: String
    var password: String
    
    var person: Person
}

struct Person {
    var firstName: String
    var secondName: String
    
    var about: String?
    var hobbie: String?
    var helth: String?
}




