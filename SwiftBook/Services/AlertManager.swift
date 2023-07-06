//
//  AlertManager.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 20.06.2023.
//


import UIKit

enum TaskStatusAlert {
    
    case newTask
    case editTask
    
    var title: String {
        switch self {
        case .newTask: return "Save"
        case .editTask: return "Edit"
        }
    }
    
    var message: String {
        switch self {
        case .newTask: return "You can save or cancel new task"
        case .editTask: return "You can change current task"
        }
    }
    
    var placeHolder: String {
        switch self {
        case .newTask: return "Enter new task"
        case .editTask: return "Edit task with"
        }
    }
    
}

enum TaskListStatusAlert {
    
    case newTaskList
    case editTaskList
    
    var title: String {
        switch self {
        case .newTaskList: return "Save"
        case .editTaskList: return "Edit"
        }
    }
    
    var message: String {
        switch self {
        case .newTaskList: return "You can save or cancel new task list"
        case .editTaskList: return "You can change current task list"
        }
    }
    
    var placeHolder: String {
        switch self {
        case .newTaskList: return "New task list"
        case .editTaskList: return "Edit task list with"
        }
    }
    
}

final class AlertManager {
    
    static let shared = AlertManager()
    
    private init () {}
    
    func showAlert(
        presentIn viewController: UIViewController?,
        taskListShadow: TaskListShadow?,
        completion: @escaping (String) -> Void
    ) {
        let status = taskListShadow != nil ? TaskListStatusAlert.editTaskList : TaskListStatusAlert.newTaskList
        let alert = UIAlertController(
            title: status.title,
            message: status.message,
            preferredStyle: .alert
        )
        
        let saveAction = UIAlertAction(title: status.title, style: .default) { _ in
            guard let task = alert.textFields?.first?.text, !task.isEmpty else { return }
            completion(task)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        alert.addTextField { textField in
            textField.placeholder = status.placeHolder
            textField.text = taskListShadow?.title
        }
        
        viewController?.present(alert, animated: true)
    }
    
    func showAlert(
        presentIn viewController: UIViewController?,
        taskShadow: TaskShadow?,
        completion: @escaping (String, String) -> Void
    ) {
        let status = taskShadow != nil ? TaskStatusAlert.editTask : TaskStatusAlert.newTask
        let alert = UIAlertController(
            title: status.title,
            message: status.message,
            preferredStyle: .alert
        )
        
        let saveAction = UIAlertAction(title: status.title, style: .default) { _ in
            guard let title = alert.textFields?[0].text, !title.isEmpty else { return }
            guard let note = alert.textFields?[1].text, !note.isEmpty else { return }
            completion(title, note)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        alert.addTextField { textField in
            textField.placeholder = status.placeHolder
            textField.text = taskShadow?.title ?? status.placeHolder
        }
        
        alert.addTextField { textField in
            textField.placeholder = status.placeHolder
            textField.text = taskShadow?.note ?? status.placeHolder
        }
        
        viewController?.present(alert, animated: true)
    }
    
}

