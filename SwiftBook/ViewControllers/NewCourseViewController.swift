//
//  NewCourseViewController.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 28.05.2023.
//

import UIKit

protocol NewCourseViewControllerDelegate: AnyObject {
    func sendPostRequest(with data: Course)
}

class NewCourseViewController: UIViewController {

    @IBOutlet var courseTitleTF: UITextField!
    @IBOutlet var numberOfLessonsTF: UITextField!
    @IBOutlet var numberOfTestsTF: UITextField!
    
    weak var delegate: NewCourseViewControllerDelegate?
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        let course = Course(
            name: courseTitleTF.text ?? "Noname",
            imageUrl: Link.courseImageURL.url.absoluteString,
            numberOfLessons: Int(numberOfLessonsTF.text ?? "") ?? 0,
            numberOfTests: Int(numberOfTestsTF.text ?? "") ?? 0
        )
        delegate?.sendPostRequest(with: course)
        dismiss(animated: true)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }

}
