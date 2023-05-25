//
//  SWAPI.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 19.05.2023.
//

import Foundation



struct Swapi: Decodable {
    
    let planets: [Planet]
    
}

extension Swapi {
    
    var names: Set<String> {
        var names: Set<String> = []
        
        for planet in planets {
            names.insert(planet.name)
        }
        
        return names
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
