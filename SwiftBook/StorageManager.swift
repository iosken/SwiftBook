//
//  StorageManager.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 14.06.2023.
//

import Foundation

// MARK: - CRUD

protocol StorageManagerProtocol {
    func set(_ object: Any?, forKey key: StorageManager.Keys)
    func set<T: Encodable>(object: T?, forKey key: StorageManager.Keys)
    
    func int(forKey key: StorageManager.Keys) -> Int?
    func string(forKey key: StorageManager.Keys) -> String?
    func dict(forKey key: StorageManager.Keys) -> [String: Any]?
    func date(forKey key: StorageManager.Keys) -> Date?
    func bool(forKey key: StorageManager.Keys) -> Bool?
    func codableData<T: Decodable>(forKey key: StorageManager.Keys) -> T?
}

final class StorageManager {
    static let shared = StorageManager()
    
    private init() {}
    
    enum Keys: String {
        case textFieldText
    }
    
    private let userDefaults = UserDefaults.standard
    
    private func store(_ object: Any?, key: String) {
        DispatchQueue.global(qos: .userInteractive).async {
            userDefaults.set(object, forKey: key)
        }
    }
    
    private func restore(forKey key: String) -> Any? { //optional to return nil if nothing to restore
        userDefaults.object(forKey: key)
    }
}

// MARK: - StorageManagerProtocol

extension StorageManager: StorageManagerProtocol {
    func set(_ object: Any?, forKey key: Keys) {
        store(object, key: key.rawValue)
    }
    
    func set<T: Encodable>(object: T?, forKey key: Keys) {
        let jsonData = try? JSONEncoder().encode(object)
        store(jsonData, key: key.rawValue)
    }
    
    func int(forKey key: Keys) -> Int? {
        restore(forKey: key.rawValue) as? Int
    }
    
    func string(forKey key: Keys) -> String? {
        restore(forKey: key.rawValue) as? String
    }
    
    func dict(forKey key: Keys) -> [String : Any]? {
        restore(forKey: key.rawValue) as? [String : Any]
    }
    
    func date(forKey key: Keys) -> Date? {
        restore(forKey: key.rawValue) as? Date
    }
    
    func bool(forKey key: Keys) -> Bool? {
        restore(forKey: key.rawValue) as? Bool
    }
    
    func date(forKey key: Keys) -> Data? {
        restore(forKey: key.rawValue) as? Data
    }
    
    func codableData<T: Decodable>(forKey key: Keys) -> T? {
        guard let data = restore(forKey: key.rawValue) as? Data else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
    
    func remove(forKey key: Keys) {
        userDefaults.removeObject(forKey: key.rawValue)
    }
}
