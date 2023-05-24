//
//  Genderize.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 19.05.2023.
//

import Foundation

struct Genderize: Decodable {
    let count: Int
    let gender: String
    let name: String
    let probability: Double
}

extension Genderize {
    var description: String {
                """
            Current name is \(name)
            with ID \(count)
            and probability \(probability)
            names gender is \(gender)
        """
    }
}


//SOURCE:
//https://api.genderize.io/?name=scott
//{"count":545658,
//    "gender":"male",
//    "name":"scott",
//    "probability":1.0}
// {"count":545658,"gender":"male","name":"scott","probability":1.0}
