//
//  NetworkManager.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 19.05.2023.
//

import Foundation

enum Link: String, CaseIterable {
    case emojihub = "https://emojihub.yurace.pro/api/random"
    case swapi = "https://swapi.dev/api/planets/"
    case wallstreetbet = "https://tradestie.com/api/v1/apps/reddit"
    
    static func genderize(from ending: String?) -> String {
        "https://api.genderize.io/?name=" + (ending ?? "Scott")
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetch<T: Decodable>(dataType: T.Type, from url: String?, completion: @escaping(Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let type = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(type))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    private init() {}
    
}
