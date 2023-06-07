//
//  ContactAdd.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 07.06.2023.
//

import Foundation

struct ContactAdd: Codable {
    let firstName: String
    let lastName: String
    
    var fullName: String {
        "\(firstName) \(lastName)"
    }
}
