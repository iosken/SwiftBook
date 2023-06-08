//
//  StorageManager.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 07.06.2023.
//

import Foundation

final class StorageManager {
    
    static let shared = StorageManager()
    
    private let fileURL = URL.documentsDirectory.appending(path: "Contacts").appendingPathExtension("plist")
    
    private init() {
//        print(fileURL)
    }
    
    func fetchContacts() -> [ContactShort] {
        guard let data = try? Data(contentsOf: fileURL) else { return [] }
        guard let contacts = try? PropertyListDecoder().decode([ContactShort].self, from: data) else { return [] }
        return contacts
    }
    
    func save(contact: ContactShort) {
        var contacts = fetchContacts()
        contacts.append(contact)
        guard let data = try? PropertyListEncoder().encode(contacts) else { return }
        try? data.write(to: fileURL, options: .noFileProtection)
    }
    
    func deleteContact(at index: Int) {
        var contacts = fetchContacts()
        contacts.remove(at: index)
        guard let data = try? PropertyListEncoder().encode(contacts) else { return }
        try? data.write(to: fileURL, options: .noFileProtection)
    }
    
}
