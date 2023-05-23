//
//  SWAPI.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 19.05.2023.
//

import Foundation

struct SWAPI: Decodable {
    let name: String
    let rotationPeriod: String
    let orbitalPeriod: String
    let diameter: String
    let climate: String
    let gravity: String
    let terrain: String
    let surfaceWater: String
    let population: String
    let films: [String]
    let created: String
    let edited: String
    let url: String
}


//SOURCE:
//https://swapi.dev/api/planets/3/?format=json
//{
//"name":"Yavin IV",
//"rotation_period":"24",
//"orbital_period":"4818",
//"diameter":"10200",
//"climate":"temperate, tropical",
//"gravity":"1 standard",
//"terrain":"jungle, rainforests",
//"surface_water":"8",
//"population":"1000",
//"residents":[],
//"films":["https://swapi.dev/api/films/1/"],
//"created":"2014-12-10T11:37:19.144000Z",
//"edited":"2014-12-20T20:58:18.421000Z",
//"url":"https://swapi.dev/api/planets/3/"
//}
