//
//  SWAPI.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 19.05.2023.
//

import Foundation

struct SwapiPlanet: Decodable, Equatable {
    
    let name: String
    let rotationPeriod: String
    let orbitalPeriod: String
    let diameter: String
    let climate: String
    let gravity: String
    let terrain: String
    let surfaceWater: String
    let population: String
    let residents: [String]
    let films: [String]
    let created: String
    let edited: String
    let url: String
    
    init(data: [String: Any]) {
        name = data["name"] as? String ?? ""
        rotationPeriod = data["rotationPeriod"] as? String ?? ""
        orbitalPeriod = data["orbitalPeriod"] as? String ?? ""
        diameter = data["diameter"] as? String ?? ""
        climate = data["climate"] as? String ?? ""
        gravity = data["gravity"] as? String ?? ""
        terrain = data["terrain"] as? String ?? ""
        surfaceWater = data["surfaceWater"] as? String ?? ""
        population = data["population"] as? String ?? ""
        residents = data["residents"] as? [String] ?? [""]
        films = data["films"] as? [String] ?? [""]
        created = data["created"] as? String ?? ""
        edited = data["edited"] as? String ?? ""
        url = data["url"] as? String ?? ""
    }
}

extension SwapiPlanet: ParsingCollection {
    
    static func getData(from value: Any) -> [SwapiPlanet] {
        guard let value = value as? [String: Any] else { return []}
        guard let contacts = value["results"] as? [[String: Any]] else { return []}
        
        return contacts.map { SwapiPlanet(data: $0) }
    }
    
    static func names(from planets: [SwapiPlanet]) -> [String] {
        planets.map { $0.name }
    }
}

extension SwapiPlanet {
    
    var description: String {
                """
        Description:
            Current planet is \(name)
            with rotationPeriod \(rotationPeriod)
            and orbitalPeriod \(orbitalPeriod)
            and another parameters:
            diameter \(diameter)
            climate: \(climate)
            gravity: \(gravity)
            terrain: \(terrain)
            surfaceWater: \(surfaceWater)
            population: \(population)
            films: \(films)
            created: \(created)
            edited: \(edited)
            url: \(url)
        """
    }
    
}

