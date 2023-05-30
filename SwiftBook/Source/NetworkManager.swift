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
    case wallstreetbet
    
    var url: URL {
        switch self {
        case .emojihub:
            return URL(string: "https://emojihub.yurace.pro/api/random")!
        case .swapi:
            return URL(string: "https://emojihub.yurace.pro/api/random")!
        case .wallstreetbet:
            return URL(string: "https://emojihub.yurace.pro/api/random")!
        }
    }
    
    static func genderize(from name: String) -> URL {
        URL(string: "https://api.genderize.io/?name=" + (name))!
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData<T: Parsing & Decodable>(type: T.Type, from url: URL, completion: @escaping(Result<T, AFError>) -> Void) {
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
    
    func fetchData<T: ParsingCollection & Decodable>(type: T.Type, from url: URL, completion: @escaping(Result<[T], AFError>) -> Void) {
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
    
    
    
}
