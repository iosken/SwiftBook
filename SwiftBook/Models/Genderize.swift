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

