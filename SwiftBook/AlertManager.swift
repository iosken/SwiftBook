//
//  AlertManager.swift
//  TaskList
//
//  Created by Yuri Volegov on 12.06.2023.
//

import Foundation
import UIKit

enum StatusAlert {
    case save
    case update
}

extension StatusAlert {
    
    var title: String {
        switch self {
        case .save: return "Save"
        case .update: return "Update"
        }
    }
    
    var message: String {
        switch self {
        case .save: return "You can save or cancel new task"
        case .update: return "You can change current task"
        }
    }
    
    var placeHolder: String {
        switch self {
        case .save: return "New task"
        case .update: return "Update task with"
        }
    }
    
}

class AlertManager {
    static let shared = AlertManager()
    
    private init () {}
    
    func showAlert(from linkObject: UIViewController?, status: StatusAlert, completion: @escaping (_ task: String) -> Void) {
            let alert = UIAlertController(title: status.title, message: status.message, preferredStyle: .alert)
            
            let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
                guard let task = alert.textFields?.first?.text, !task.isEmpty else { return }
                completion(task)
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
            alert.addAction(saveAction)
            alert.addAction(cancelAction)
            alert.addTextField { textField in
                textField.placeholder = status.placeHolder
            }
    
            linkObject?.present(alert, animated: true)
    
        }
    
}

