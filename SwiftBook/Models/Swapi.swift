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
        results = data["results"] as? [Planet] ?? []
    }
    
    static func getData(from value: Any) -> Swapi {
        
        print("getData Swapi called!")
        guard let swapiData = value as? [String: Any] else {
            
            print("!!!!!!!!!!!! getData swapiData - NOTHING")
            
            return Swapi(data: [:])
            
        }
        
        print(">>>>>swapiData")

        return Swapi(data: swapiData)
    }
    
}

struct Planet: Decodable {
    
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
//    init(data: Any) {
//        
//    }
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
