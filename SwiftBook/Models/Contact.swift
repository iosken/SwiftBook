//
//  RandomUser.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 31.05.2023.
//

import Foundation


struct Contact: Decodable {
    
    let gender: String
    let name: Name
    let location: Location
    let email: String
    let login: Login
    let dob: Dob
    let registered: Registered
    let phone: String
    let cell: String
    let id: UserID
    let picture: Picture
    let nat: String
    
    init(data: [String: Any]) {
        let genderData = data["gender"] as? String ?? ""
        gender = genderData
        
        let nameData = data["name"] as? [String: String] ?? [:]
        name = Name(data: nameData)
        
        let locationData = data["location"] as? [String: Any] ?? [:]
        location = Location(data: locationData)
        
        let emailData = data["email"] as? String ?? ""
        email = emailData
        
        let loginData = data["login"] as? [String: String] ?? [:]
        login = Login(data: loginData)
        
        let dobData = data["dob"] as? [String : Any] ?? [:]
        dob = Dob(data: dobData)
        
        let registredData = data["registered"] as? [String : Any] ?? [:]
        registered = Registered(data: registredData)
        
        let phoneData = data["phone"] as? String ?? ""
        phone = phoneData
        
        cell = data["cell"] as? String ?? ""
        
        let idData = data["id"] as? [String : Any] ?? [:]
        id = UserID(data: idData)
        
        let pictureData = data["picture"] as? [String : String] ?? [:]
        picture = Picture(data: pictureData)
        
        let natData = data["nat"] as? String ?? ""
        nat = natData
    }
    
}

extension Contact: ParsingCollection {
    
    static func getData(from value: Any) -> [Contact] {
        guard let value = value as? [String: Any] else { return []}
        guard let contacts = value["results"] as? [[String: Any]] else { return [] }
        
        return contacts.compactMap { Contact(data: $0) }
    }
    
}

// MARK: - Name

struct Name: Decodable {
    
    let title: String
    let first: String
    let last: String
    
    var fullName: String {
        """
\(title)
\(first)
\(last)
"""
    }
    
    init(data: [String: String]) {
        title = data["title"] ?? ""
        first = data["first"] ?? ""
        last = data["last"] ?? ""
    }
    
}

// MARK: - Location

struct Location: Decodable {
    
    let street: Street
    let city: String
    let state: String
    let country: String
    let postcode: Int
    let coordinates: Coordinates
    let timezone: Timezone
    
    init(data: [String: Any]) {
        let streetData = data["street"] as? [String: Any] ?? [:]
        street = Street(data: streetData)
        
        city = data["city"] as? String ?? ""
        state = data["state"] as? String ?? ""
        country = data["country"] as? String ?? ""
        postcode = data["postcode"] as? Int ?? 0
        
        let coordinatesData = data["coordinates"] as? [String: String] ?? [:]
        coordinates = Coordinates(data: coordinatesData)
        
        let timezoneData = data["timezone"] as? [String: String] ?? [:]
        timezone = Timezone(data: timezoneData)
    }
    
}

// MARK: - Street

struct Street: Decodable {
    
    let number: Int
    let name: String
    
    init(data: [String: Any]) {
        let numberData = data["number"] as? Int ?? 0
        number = numberData
        
        let nameData = data["name"] as? String ?? ""
        name = nameData
    }
    
}

// MARK: - Coordinates

struct Coordinates: Decodable {
    
    let latitude: String
    let longitude: String
    
    init(data: [String: String]) {
        latitude = data["latitude"] ?? ""
        longitude = data["longitude"] ?? ""
    }
    
}

// MARK: - Timezone

struct Timezone: Decodable {
    
    let offset: String
    let description: String
    
    init(data: [String: String]) {
        offset = data["offset"] ?? ""
        description = data["description"] ?? ""
    }
    
}

// MARK: - Login

struct Login: Decodable {
    
    let uuid: String
    let username:String
    let password: String
    let salt: String
    let md5: String
    let sha1: String
    let sha256: String
    
    init(data: [String: String]) {
        uuid = data["uuid"] ?? ""
        username = data["username"] ?? ""
        password = data["password"] ?? ""
        salt = data["salt"] ?? ""
        md5 = data["md5"] ?? ""
        sha1 = data["sha1"] ?? ""
        sha256 = data["sha256"] ?? ""
    }
    
}

// MARK: - Dob

struct Dob: Decodable {
    
    let date: String
    let age: Int
    
    init(data: [String: Any]) {
        let dateData = data["date"] as? String ?? ""
        date = dateData
        
        let ageData = data["age"] as? Int ?? 0
        age = ageData
    }
    
}

// MARK: - Registred

struct Registered: Decodable {
    
    let date: String
    let age: Int
    
    init(data: [String: Any]) {
        let dateData = data["date"] as? String ?? ""
        date = dateData
        
        let ageData = data["age"] as? Int ?? 0
        age = ageData
    }
    
}

// MARK: - UserID

struct UserID: Decodable {
    let name: String
  //  let value: Any?
    
    init(data: [String: Any]) {
        
        let nameData = data["name"] as? String ?? ""
        name = nameData
        
   //     value = data["value"]
    }
}

// MARK: - Picture

struct Picture: Decodable, Parsing {

    let large: String
    let medium: String
    let thumbnail: String?
    
    init(data: [String: Any]) {
        large = data["large"] as? String ?? ""
        medium = data["medium"] as? String ?? ""
        thumbnail = data["thumbnail"] as? String ?? ""
    }
    
    static func getData(from value: Any) -> Picture {
        guard let data = value as? [String: Any] else { return Picture(data: [:]) }
        
        return Picture(data: data)
    }
    
}
