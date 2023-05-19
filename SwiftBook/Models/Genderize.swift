//
//  Genderize.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 19.05.2023.
//

import Foundation

struct Genderize: Decodable {
    let count: Int?
    let gender: String?
    let name: String?
    let probability: Double?
}


//SOURCE:
//https://api.genderize.io/?name=scott
//{"count":545658,
//    "gender":"male",
//    "name":"scott",
//    "probability":1.0}
