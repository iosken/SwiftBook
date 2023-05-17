//
//  Course.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 12.05.2023.
//

import Foundation

struct Course: Decodable {
    let name: String?
    let imageUrl: String?
    let numberOfLessons: Int?
    let numberOfTests: Int?
}

struct WebsiteDesctiption: Decodable {
    let courses: [Course]?
    let websiteDescription: String?
    let websiteName: String?
}
