//
//  WelcomeModel.swift
//  SwiftBook
//
//  Created by Yuri on 12.01.2023.
//

import Foundation

class SignedUsers {
    var users: [String: UserProperties] = [ // key is user name (login)
        "User" : UserProperties(
            password: "1234",
            recoveryEmail: "User",
            person: Person(
                firstName: "DefaultUser",
                secondName: "DefaultUser",
                about: "Some information \"About\" to test",
                pet: "Some information \"About pet\" to test",
                sport: "Some information \"About sport\" to test"
            )
        )
    ]
}

struct UserProperties {
    var password: String
    var recoveryEmail: String
    let dateSignIn = Date.now
    
    var person: Person
}

struct Person {
    var firstName: String
    var secondName: String
    
    var about: String?
    var pet: String?
    var sport: String?
}

extension SignedUsers {
    func signUp(
        login: String,
        password: String,
        recoveryEmail: String,
        firstName: String,
        secondName: String,
        about: String?,
        pet: String?,
        sport: String?
    ) {
        users[login] = UserProperties(
            password: password,
            recoveryEmail: recoveryEmail,
            person: Person(
                firstName: firstName,
                secondName: secondName,
                about: about,
                pet: pet,
                sport: sport
            )
        )
    }
}




