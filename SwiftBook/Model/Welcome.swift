//
//  WelcomeModel.swift
//  SwiftBook
//
//  Created by Yuri on 12.01.2023.
//

import Foundation

class SignedUsers {
    var users: [String: UserProperties] = [ // key is user name (login)
        "TEXHA" : UserProperties(
            password: "1234",
            recoveryEmail: "y.volegov@icloud.com",
            person: Person(
                firstName: "Yuri",
                secondName: "Volegov",
                about: """
                Hi there!
                
                I am 36 years old. I am team lead of little group IT-engeneers about 5 years. I wish to learn Swift to become software developer. I planning to buy MacBook 16. It will be my little present for learning hard all  SwiftBook tasks. I hope it will push learning work faster. Moreover I believe that tool should inspire to making great job. I planning to learn some English and Mathimatic too. Mathimatic interesting with integral, becouse it need to learn some of algorithms. Hope it  will be my way and I can move to it.

                I planning to be friend of SwiftBook and big THANK you!
                
                And One More Thing: I have a one cute cat and his name is Simon. He likes to often scrape the tray."
                """
            )
        )
    ]
    
    var currentUserName = ""
    
    var currentUserProperties: UserProperties? {
        users[currentUserName]
    }
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
}

extension SignedUsers {
    func signUp(
        login: String,
        password: String,
        recoveryEmail: String,
        firstName: String,
        secondName: String,
        about: String?
    ) {
        users[login] = UserProperties(
            password: password,
            recoveryEmail: recoveryEmail,
            person: Person(
                firstName: firstName,
                secondName: secondName,
                about: about
            )
        )
    }
}

extension UserProperties {
    func values() -> [String] {
        var userPropertiesValues = [""]
        userPropertiesValues.append(self.recoveryEmail)
        userPropertiesValues.append(self.person.firstName)
        userPropertiesValues.append(self.person.secondName)
        userPropertiesValues.append(self.person.about ?? "")
        userPropertiesValues.append(self.dateSignIn.formatted())
        
        return userPropertiesValues
    }
}




