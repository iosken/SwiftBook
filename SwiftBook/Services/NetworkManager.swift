//
//  NetworkManager.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 17.05.2023.
//

import Foundation

import Alamofire

enum Link {
    case coursesURL
    case postRequest
    case courseImageURL
    
    var url: URL {
        switch self {
        case .coursesURL:
            return URL(string: "https://swiftbook.ru//wp-content/uploads/api/api_courses")!
        case .postRequest:
            return URL(string: "https://jsonplaceholder.typicode.com/posts")!
        case .courseImageURL:
            return URL(string: "https://swiftbook.ru/wp-content/uploads/sites/2/2018/08/notifications-course-with-background.png")!
        }
    }
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchCourses(from url: URL, completion: @escaping(Result<[Course], AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let courses = Course.getCourses(from: value)
                    completion(.success(courses))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchData(from url: String, completion: @escaping(Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { dataResponse in
                switch dataResponse.result {
                case .success(let imageData):
                    completion(.success(imageData))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func sendPostRequest(to url: URL, with data: Course, completion: @escaping(Result<Course, AFError>) -> Void) {
        AF.request(url, method: .post, parameters: data)
            .validate()
            .responseDecodable(of: CourseAdapter.self) { dataResponse in
                switch dataResponse.result {
                case .success(let courseAdapter):
                    let course = Course(courseAdapter: courseAdapter)
                    completion(.success(course))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
