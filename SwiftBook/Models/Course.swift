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
    let number_of_lessons: Int?
    let number_of_tests: Int?
}

struct WebsiteDesctiption: Decodable {
    let courses: [Course]?
    let websiteDescription: String?
    let websiteName: String?
}
