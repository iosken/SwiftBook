//
//  SuperHeroe.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 05.06.2023.
//

import Foundation

// MARK: - WelcomeElement

struct Superhero: Decodable, ParsingCollection {
    
    let id: Int
    let name: String
    let slug: String
    let powerstats: Powerstats
    let appearance: Appearance
    let biography: Biography
    let work: Work
    let connections: Connections
    let images: Images
    
    init(data: [String: Any]) {
        id = data["id"] as? Int ?? 0
        name = data["name"] as? String ?? ""
        slug = data["slug"] as? String ?? ""
        
        let powerstatsData = data["powerstats"] as? [String: Int] ?? [:]
        powerstats = Powerstats(from: powerstatsData)
        
        let appearanceData = data["appearance"] as? [String: Any] ?? [:]
        appearance = Appearance(from: appearanceData)
        
        let biographyData = data["biography"] as? [String: Any] ?? [:]
        biography = Biography(from: biographyData)
        
        let workData = data["work"] as? [String: String] ?? [:]
        work = Work(from: workData)
        
        let connectionsData = data["connections"] as? [String: String] ?? [:]
        connections = Connections(from: connectionsData)
        
        let imagesData = data["images"] as? [String: String] ?? [:]
        images = Images(from: imagesData)
    }
    
    static func getData(from value: Any) -> [Superhero] {
        guard let valueData = value as? [[String: Any]] else { return [] }
        return valueData.compactMap { Superhero(data: $0) }
    }
    
}

// MARK: - Appearance

struct Appearance: Decodable {
    
    let gender: Gender
    let race: String?
    let height: [String]
    let weight: [String]
    let eyeColor: String
    let hairColor: String
    
    init(from data: [String: Any]) {
        let genderData = data["gender"] as? String ?? ""
        gender = Gender(from: genderData)
        
        race = data["race"] as? String
        height = data["height"] as? [String] ?? []
        weight = data["height"] as? [String] ?? []
        eyeColor = data["eyeColor"] as? String ?? ""
        hairColor = data["hairColor"] as? String ?? ""
    }
    
}

// MARK: - Gender

enum Gender: String, Decodable {
    
    case empty = "-"
    case female = "Female"
    case male = "Male"
    
    init(from data: String) {
        switch data {
        case "-":
            self = .empty
        case "Female":
            self = .female
        default:
            self = .male
        }
    }
    
}

// MARK: - Biography

struct Biography: Decodable {
    
    let fullName: String
    let alterEgos: String
    let aliases: [String]
    let placeOfBirth: String
    let firstAppearance: String
    let publisher: String?
    let alignment: Alignment
    
    init(from data: [String: Any]) {
        fullName = data["fullName"] as? String ?? ""
        alterEgos = data["alterEgos"] as? String ?? ""
        aliases = data["aliases"] as? [String] ?? []
        placeOfBirth = data["placeOfBirth"] as? String ?? ""
        firstAppearance = data["firstAppearance"] as? String ?? ""
        publisher = data["publisher"] as? String
        
        let alignmentData = data["alignment"] as? String ?? ""
        alignment = Alignment(from: alignmentData)
    }
    
}

// MARK: - Alignment
enum Alignment: String, Decodable {
    
    case bad = "bad"
    case empty = "-"
    case good = "good"
    case neutral = "neutral"
    
    init(from data: String) {
        switch data {
        case "bad":
            self = .bad
        case "-":
            self = .empty
        case "good":
            self = .good
        default:
            self = .neutral
        }
    }
    
}

// MARK: - Connections

struct Connections: Decodable {
    
    let groupAffiliation: String
    let relatives: String
    
    init(from data: [String: String]) {
        groupAffiliation = data["groupAffiliation"] ?? ""
        relatives = data["relatives"] ?? ""
    }
    
}

// MARK: - Images

struct Images: Decodable {
    
    let xs: String
    let sm: String
    let md: String
    let lg: String
    
    init(from data: [String: String]) {
        xs = data["xs"] ?? ""
        sm = data["sm"] ?? ""
        md = data["md"] ?? ""
        lg = data["lg"] ?? ""
    }
    
}

// MARK: - Powerstats

struct Powerstats: Decodable {
    
    let intelligence: Int
    let strength: Int
    let speed: Int
    let durability: Int
    let power: Int
    let combat: Int
    
    init(from data: [String: Int]) {
        intelligence = data["intelligence"] ?? 0
        strength = data["strength"] ?? 0
        speed = data["speed"] ?? 0
        durability = data["durability"] ?? 0
        power = data["power"] ?? 0
        combat = data["combat"] ?? 0
    }
    
}

// MARK: - Work

struct Work: Decodable {
    
    let occupation: String
    let base: String
    
    init(from data: [String: String]) {
        occupation = data["occupation"] ?? ""
        base = data["base"] ?? ""
    }
    
}
