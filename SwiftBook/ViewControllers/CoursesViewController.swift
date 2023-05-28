//
//  CoursesViewController.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 11.05.2023.
//

import UIKit



final class CoursesViewController: UITableViewController {
    
    private var courses: [Course] = []
    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
        fetchCourses()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationVC = segue.destination as? UINavigationController else { return }
        guard let newCourseVC = navigationVC.topViewController as? NewCourseViewController else { return }
        newCourseVC.delegate = self
    }
    
    private func fetchCourses() {
        networkManager.fetchCourses(from: Link.coursesURL.url) { [weak self] result in
            switch result {
            case .success(let courses):
                self?.courses = courses
                self?.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}

// MARK: - NewCourseViewControllerDelegate
extension CoursesViewController: NewCourseViewControllerDelegate {
    func sendPostRequest(with data: Course) {
        networkManager.sendPostRequest(to: Link.postRequest.url, with: data) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let course):
                self.courses.append(course)
                self.tableView.insertRows(
                    at: [IndexPath(row: self.courses.count - 1, section: 0)],
                    with: .automatic
                )
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension CoursesViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        courses.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let cell = cell as? CourseCell else { return UITableViewCell() }
        let course = courses[indexPath.row]
        cell.configure(with: course)
        return cell
    }
}
