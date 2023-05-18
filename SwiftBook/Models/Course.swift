//
//  Course.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 12.05.2023.
//

import Foundation

struct Course: Codable {
    let name: String?
    let imageUrl: String?
    let numberOfLessons: Int?
    let numberOfTests: Int?
}

struct SwiftBookInfo: Decodable {
    let courses: [Course]?
    let websiteDescription: String?
    let websiteName: String?
}
