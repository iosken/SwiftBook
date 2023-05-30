//
//  SWAPI.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 19.05.2023.
//

import Foundation

struct Swapi: Decodable {
    
    let results: [Planet]
    
}

extension Swapi {
    
    var names: [String] {
        var names: [String] = []
        
        for result in results {
            names.append(result.name)
        }
        
        return names
    }
    
}

extension Swapi: Parsing {
    
    init(data: [String: Any]) {
        guard let resultsData = data["results"] as? [[String: Any]] else {
            results = []
            return
        }
        
        results = resultsData.map { Planet(data: $0) }
    }
    
    static func getData(from value: Any) -> Swapi {
        guard let swapiData = value as? [String: Any] else {
            return Swapi(data: [:])
        }
        
        return Swapi(data: swapiData)
    }
    
}

struct Planet: Decodable, Equatable {
    
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
    
}

extension Planet {
    
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

extension Planet {
    
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
