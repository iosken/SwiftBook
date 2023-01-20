//
//  WelcomeModel.swift
//  SwiftBook
//
//  Created by Yuri on 12.01.2023.
//

struct UsersAccounts {
    private var users: [String: User] = [:]
}

struct User {
    let login: String
    let password: String
    
    let person: Person
}

struct Person {
    var firstName: String
    var secondName: String
    
    var about: String?
    var hobbie: String?
    var helth: String?
}

extension UsersAccounts {
    mutating func signUp(
        login: String,
        password: String,
        firstName: String,
        secondName: String,
        about: String?,
        hobbie: String?,
        helth: String?
    ) {
        users = [
            login + password : User(
                login: login,
                password: password,
                person: Person(
                    firstName: firstName,
                    secondName: secondName,
                    about: about,
                    hobbie: hobbie,
                    helth: helth
                )
            )
        ]
    }
    
    func signIn(login: String, password: String) -> User? {
        users.keys.contains(login + password) ? users[login + password] : nil
    }
}




