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

extension Wallstreetbet: ParsingCollection {
    
    init(data: [String: Any]) {
        noOfComments = data["no_of_comments"] as? Int ?? 0
        sentiment = data["sentiment"] as? String ?? ""
        sentimentScore = data["sentiment_score"] as? Double ?? 0
        ticker = data["ticker"] as? String ?? ""
    }
    
    static func getData(from value: Any) -> [Wallstreetbet] {
        guard let wallstreetbetData = value as? [[String: Any]] else { return [] }
        
        return wallstreetbetData.map { Wallstreetbet(data: $0) }
    }
    
}
