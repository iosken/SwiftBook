//
//  NetworkExamplesCollectionViewController.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 11.05.2023.
//

import UIKit

enum UserAction: String, CaseIterable {
    case showImage = "Show Image"
    case fetchCourse = "Fetch Course"
    case fetchCourses = "Fetch Courses"
    case aboutSwiftBook = "About SwiftBook"
    case aboutSwiftBook2 = "About SwiftBook 2"
    case showCourses = "Show Courses"
    case postRequestWithDict = "POST RQST with Dict"
    case postRequestWithModel = "POST RQST with Model"
}

class NetworkExamplesViewController: UICollectionViewController {
    
    private let userActions = UserAction.allCases
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userActions.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? UserActionCell
        else { return  UICollectionViewCell() }
        
        let userAction = userActions[indexPath.item]
        
        cell.userActionLabel.text = userAction.rawValue
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.item]
        
        switch userAction {
        case .showImage: performSegue(withIdentifier: "showImage", sender: nil)
        case .fetchCourse: fetchCourse()
        case .fetchCourses: fetchCourses()
        case .aboutSwiftBook: fetchInfoAboutUs()
        case .aboutSwiftBook2: fetchInfoAboutUsWithEmptyFields()
        case .showCourses: performSegue(withIdentifier: "showCourses", sender: nil)
        case .postRequestWithDict: postRequestWithDict()
        case .postRequestWithModel: postRequestWithModel()
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCourses" {
            guard let courseVC = segue.destination as? CoursesViewController else { return }
            courseVC.fetchCourses()
        }
    }
    
    // MARK: - Private Methods
    private func successAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Success",
                message: "You can see the results in the Debug aria",
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
    
    private func failedAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Failed",
                message: "You can see error in the Debug aria",
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
}

extension NetworkExamplesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
    }
}

// MARK: - Networking
extension NetworkExamplesViewController {
    private func fetchCourse() {
        NetworkManager.shared.fetch(Course.self, from: Link.courseURL.rawValue) { [weak self] result in
            switch result {
            case .success(let course):
                print(course)
                self?.successAlert()
            case .failure(let error):
                print(error)
                self?.failedAlert()
            }
        }
    }
    
    
    private func fetchCourses() {
        NetworkManager.shared.fetch([Course].self, from: Link.coursesURL.rawValue) { [weak self] result in
            switch result {
            case .success(let courses):
                print(courses)
                self?.successAlert()
            case .failure(let error):
                print(error)
                self?.failedAlert()
            }
        }
    }
    
    private func fetchInfoAboutUs() {
        NetworkManager.shared.fetch(SwiftBookInfo.self.self, from: Link.aboutUsURL.rawValue) { [weak self] result in
            switch result {
            case .success(let info):
                print(info)
                self?.successAlert()
            case .failure(let error):
                print(error)
                self?.failedAlert()
            }
        }
    }
    
    private func fetchInfoAboutUsWithEmptyFields() {
        NetworkManager.shared.fetch(SwiftBookInfo.self, from: Link.aboutUsURL2.rawValue) { [weak self] result in
            switch result {
            case .success(let info):
                print(info)
                self?.successAlert()
            case .failure(let error):
                print(error)
                self?.failedAlert()
            }
        }
    }
    
    private func postRequestWithDict() {
        let course = [
            "name": "Networking",
            "imageURL": "Image url",
            "numberOfLessons": "10",
            "numberOfTests": "8"
        ]
        NetworkManager.shared.postRequest(with: course, to: Link.postRequest.rawValue) { [weak self] result in
            switch result {
            case .success(let json):
                print(json)
                self?.successAlert()
            case .failure(let error):
                print(error)
                self?.failedAlert()
            }
        }
    }
    
    private func postRequestWithModel() {
        let course = Course(
            name: "Networking",
            imageUrl: Link.courseImageURL.rawValue,
            numberOfLessons: 10,
            numberOfTests: 5
        )
        
        NetworkManager.shared.postRequest(with: course, to: Link.postRequest.rawValue) { [weak self] result in
            switch result {
                
            case .success(let course):
                print(course)
                self?.successAlert()
            case .failure(let error):
                print(error)
                self?.failedAlert()
            }
        }
    }
    
    
    
}
