//
//  NetworkManager.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 19.05.2023.
//

import Foundation
import Alamofire

enum Link {
    case emojihub
    case swapi
    case wallstreetbets
    case contacts
    
    var url: URL? {
        switch self {
        case .emojihub:
            return URL(string: "https://emojihub.yurace.pro/api/random") // model
        case .swapi:
            return URL(string: "https://swapi.dev/api/planets/") // model with array property
        case .wallstreetbets:
            return URL(string: "https://tradestie.com/api/v1/apps/reddit") // array
        case .contacts:
            return URL(string: "https://randomuser.me/api/") // model with array property
        }
    }
    
    static func genderize(from name: String) -> URL? {
        URL(string: "https://api.genderize.io/?name=" + (name)) // model
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let urlParams = [
        "results":"\(15)",
    ]
    
    private init() {}
    
    func fetchData(fromData url: URL?, completion: @escaping(Result<Data, AFError>) -> Void) {
        guard let url = url else { return }
        
        AF.request(url)
            .validate()
            .responseData { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                    print(error.localizedDescription)
                }
            }
    }
    
    func fetchData<T: Parsing & Decodable>(type: T.Type, fromJson url: URL?, completion: @escaping(Result<T, AFError>) -> Void) {
        guard let url = url else { return }
        
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let model = T.getData(from: value)
                    completion(.success(model))
                case .failure(let error):
                    completion(.failure(error))
                    print(error.localizedDescription)
                }
            }
    }
    
    func fetchData<T: ParsingCollection & Decodable>(type: T.Type, fromJson url: URL?, completion: @escaping(Result<[T], AFError>) -> Void) {
        guard let url = url else { return }
        
        AF.request(url, parameters: urlParams)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let model = T.getData(from: value)
                    completion(.success(model))
                case .failure(let error):
                    completion(.failure(error))
                    print(error.localizedDescription)
                }
            }
        
    }
    
}

// and:
// https://swiftbook.ru//wp-content/uploads/api/api_courses
