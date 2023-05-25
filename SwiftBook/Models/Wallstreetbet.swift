//
//  Wallstreetbet.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 19.05.2023.
//

import Foundation

struct Wallstreetbet: Decodable {
    
    let noOfComments: Int
    let sentiment: String
    let sentimentScore: Double
    let ticker: String
    
}

extension Wallstreetbet {
    
    var description: String {
        """
    number: \(noOfComments.formatted())
    sentiment: \(sentiment)
    sentimentScore: \(sentimentScore.formatted())
    ticker:\(ticker)
"""
    }
    
}
