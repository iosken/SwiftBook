//
//  ParsingCollection.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 29.05.2023.
//

import Foundation

protocol ParsingCollection {
    
    init(data: [String: Any])
    
    static func getData(from value: Any) -> [Self]
    
}
