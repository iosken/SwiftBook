//
//  Course.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 12.05.2023.
//

import Foundation

struct Course: Codable {
    let name: String
    let imageUrl: String
    let numberOfLessons: Int
    let numberOfTests: Int
    
    init(name: String, imageUrl: String, numberOfLessons: Int, numberOfTests: Int) {
        self.name = name
        self.imageUrl = imageUrl
        self.numberOfLessons = numberOfLessons
        self.numberOfTests = numberOfTests
    }
    
    init(courseData: [String: Any]) {
        name = courseData["name"] as? String ?? ""
        imageUrl = courseData["imageUrl"] as? String ?? ""
        numberOfLessons = courseData["number_of_lessons"] as? Int ?? 0
        numberOfTests = courseData["number_of_tests"] as? Int ?? 0
    }
    
    init(courseAdapter: CourseAdapter) {
        name = courseAdapter.name
        imageUrl = courseAdapter.imageUrl
        numberOfLessons = Int(courseAdapter.numberOfLessons) ?? 0
        numberOfTests = Int(courseAdapter.numberOfTests) ?? 0
    }
    
    static func getCourses(from value: Any) -> [Course] {
        guard let coursesData = value as? [[String: Any]] else { return [] }
        return coursesData.map { Course(courseData: $0) }
    }
}

struct CourseAdapter: Decodable {
    let name: String
    let imageUrl: String
    let numberOfLessons: String
    let numberOfTests: String
}
