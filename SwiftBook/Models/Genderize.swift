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

extension Genderize: Parsing {
    
    init(data: [String: Any]) {
        count = data["count"] as? Int ?? 0
        gender = data["gender"] as? String ?? ""
        name = data["name"] as? String ?? ""
        probability = data["probability"] as? Double ?? 0
    }
    
    static func getData(from value: Any) -> Genderize {
        guard let emojiData = value as? [String: Any] else { return Genderize(data: [:]) }
        
        return Genderize(data: emojiData)
    }
    
}

extension Genderize {
    
    var description: String {
                """
            Current name is \(name)
        
            with ID \(count)
        
            and probability \(probability)
        
            gender is \(gender)
        """
    }
    
}

