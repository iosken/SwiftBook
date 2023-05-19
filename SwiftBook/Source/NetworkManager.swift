//
//  NetworkManager.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 19.05.2023.
//

import Foundation

enum Link: String, CaseIterable {
    case emojihub = "https://emojihub.yurace.pro/api/random"
    case genderize = "https://api.genderize.io/?name=scott"
    case swapi = "https://swapi.dev/api/planets/3/?format=json"
    case wallstreetbet = "https://tradestie.com/api/v1/apps/reddit"
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    
    
    private init() {}
}
