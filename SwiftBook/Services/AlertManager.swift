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
        case .newTask: return "New task"
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

class AlertManager {
    
    static let shared = AlertManager()
    
    private init () {}
    
    func taskShowAlert(
        from viewController: UIViewController?,
        task: Task? = nil,
        completion: @escaping (String) -> Void
    ) {
        showAlert(from: <#T##UIViewController?#>, task: <#T##Task?#>, completion: <#T##(String) -> Void#>)
    }
    
    func taskListShowAlert(
        from viewController: UIViewController?,
        task: Task? = nil,
        completion: @escaping (String) -> Void
    ) {
        showAlert(from: <#T##UIViewController?#>, task: <#T##Task?#>, completion: <#T##(String) -> Void#>)
    }
    
    private func showAlert(
        from viewController: UIViewController?,
        task: Task? = nil,
        completion: @escaping (String) -> Void
    ) {
        let status = task != nil ? TaskStatusAlert.editTask : TaskStatusAlert.newTask
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
            textField.text = task?.title
        }
        
        viewController?.present(alert, animated: true)
    }
    
}

//-----------------------------------------------------------------------------------

    private func showAlert(with task: Task? = nil, completion: (() -> Void)? = nil) {
        let taskAlertFactory = TaskAlertControllerFactory(
            userAction: task != nil ? .editTask : .newTask,
            taskTitle: task?.title,
            taskNote: task?.note
        )
        let alert = taskAlertFactory.createAlert { [weak self] taskTitle, taskNote in
            if let task, let completion {
                self?.storageManager.edit(task, newValue: taskTitle, newNote: taskNote)
                completion()
            } else {
                self?.save(task: taskTitle, withNote: taskNote)
            }
        }

        present(alert, animated: true)
    }


//protocol TaskListAlert {
//    var listTitle: String? { get }
//    func createAlert(completion: @escaping (String) -> Void) -> UIAlertController
//}
//
//protocol TaskAlert {
//    var taskTitle: String? { get }
//    var taskNote: String? { get }
//    func createAlert(completion: @escaping (String, String) -> Void) -> UIAlertController
//}

final class TaskListAlertControllerFactory: TaskListAlert {
    var listTitle: String?
    private let userAction: UserAction

    init(userAction: UserAction, listTitle: String?) {
        self.userAction = userAction
        self.listTitle = listTitle
    }

    func createAlert(completion: @escaping (String) -> Void) -> UIAlertController {
        let alertController = UIAlertController(
            title: userAction.title,
            message: "Please set title for new task list",
            preferredStyle: .alert
        )

        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let listTitle = alertController.textFields?.first?.text else { return }
            guard !listTitle.isEmpty else { return }
            completion(listTitle)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)

        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        alertController.addTextField { [weak self] textField in
            textField.placeholder = "New List"
            textField.text = self?.listTitle
        }

        return alertController
    }
}

// MARK: - TaskListUserAction
extension TaskListAlertControllerFactory {
    enum UserAction {
        case newList
        case editList

        var title: String {
            switch self {
            case .newList:
                return "New List"
            case .editList:
                return "Edit List"
            }
        }
    }
}

final class TaskAlertControllerFactory: TaskAlert {
    var taskTitle: String?
    var taskNote: String?

    private let userAction: UserAction

    init(userAction: UserAction, taskTitle: String?, taskNote: String?) {
        self.userAction = userAction
        self.taskTitle = taskTitle
        self.taskNote = taskNote
    }

    func createAlert(completion: @escaping (String, String) -> Void) -> UIAlertController {
        let alertController = UIAlertController(
            title: userAction.title,
            message: "What do you want to do?",
            preferredStyle: .alert
        )

        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let taskTitle = alertController.textFields?.first?.text else { return }
            guard !taskTitle.isEmpty else { return }

            if let taskNote = alertController.textFields?.last?.text, !taskNote.isEmpty {
                completion(taskTitle, taskNote)
            } else {
                completion(taskTitle, "")
            }
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)

        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)

        alertController.addTextField { [weak self] textField in
            textField.placeholder = "New Task"
            textField.text = self?.taskTitle
        }

        alertController.addTextField { [weak self] textField in
            textField.placeholder = "Note"
            textField.text = self?.taskNote
        }

        return alertController
    }
}

// MARK: - TaskUserAction
extension TaskAlertControllerFactory {
    enum UserAction {
        case newTask
        case editTask

        var title: String {
            switch self {
            case .newTask:
                return "New Task"
            case .editTask:
                return "Edit Task"
            }
        }
    }
}

