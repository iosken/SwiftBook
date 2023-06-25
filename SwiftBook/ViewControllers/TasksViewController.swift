//
//  TasksViewController.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 20.06.2023.
//

import UIKit
import RealmSwift

class TasksViewController: UITableViewController {
    
    var taskList: TaskList!
    
    private var currentTasks: Results<Task>!
    private var completedTasks: Results<Task>!
    private let storageManager = StorageManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        title = taskList.title
        
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonPressed)
        )
        navigationItem.rightBarButtonItems = [addButton, editButtonItem]
        currentTasks = taskList.tasks.filter("isComplete = false")
        completedTasks = taskList.tasks.filter("isComplete = true")
    }
    
    // MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let task = indexPath.section == 0 ? currentTasks[indexPath.row] : completedTasks[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [unowned self] _, _, _ in
            storageManager.delete(task)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { [unowned self] _, _, isDone in
            showAlert(with: task) {
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            isDone(true)
        }
        
        var doneAction = UIContextualAction()
        
        if !task.isComplete {
            doneAction = UIContextualAction(style: .normal, title: "Done") { [unowned self] _, _, isDone in
                isDone(true)
                
                storageManager.done(task)
                
               // currentTasks.count : completedTasks.count
                
                var indexPathToReload: [IndexPath] = []
                
                for row in currentTasks.indices {
                    let currentIndexPath = IndexPath(row: row, section: 0)
                    indexPathToReload.append(currentIndexPath)
                }
                
                for row in completedTasks.indices {
                    let currentIndexPath = IndexPath(row: row, section: 1)
                    indexPathToReload.append(currentIndexPath)
                }
                
                tableView.reloadRows(at: indexPathToReload, with: .automatic)
                
                //tableView.reloadRows(at: [indexPath], with: .automatic)
                
                //tableView.reloadData()
            }
        } else {
            doneAction = UIContextualAction(style: .normal, title: "Undone") { [unowned self] _, _, isDone in
                isDone(true)
                
                storageManager.undone(task)
                
                var indexPathToReload: [IndexPath] = []
                
                for row in currentTasks.indices {
                    let currentIndexPath = IndexPath(row: row, section: 0)
                    indexPathToReload.append(currentIndexPath)
                }
                
                for row in completedTasks.indices {
                    let currentIndexPath = IndexPath(row: row, section: 1)
                    indexPathToReload.append(currentIndexPath)
                }
                
                tableView.reloadRows(at: indexPathToReload, with: .automatic)
                
                //tableView.reloadData()
            }
        }

        
        editAction.backgroundColor = .orange
        doneAction.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        
        return UISwipeActionsConfiguration(actions: [doneAction, editAction, deleteAction])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskList = taskList.tasks[indexPath.row]
        
        showAlert(with: taskList) {
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? currentTasks.count : completedTasks.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        section == 0 ? "CURRENT TASKS" : "COMPLETED TASKS"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TasksCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        let task = indexPath.section == 0 ? currentTasks[indexPath.row] : completedTasks[indexPath.row]
        content.text = task.title
        
        if task.isComplete {
            content.secondaryText = "✅"
        } else {
            content.secondaryText = "❎"
        }
        
        cell.contentConfiguration = content
        return cell
    }
    
    @objc private func addButtonPressed() {
        showAlert()
    }

}

extension TasksViewController {
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
    
    private func save(task: String, withNote note: String) {
        storageManager.save(task, withTaskNote: note, to: taskList) { task in
            let rowIndex = IndexPath(row: currentTasks.index(of: task) ?? 0, section: 0)
            tableView.insertRows(at: [rowIndex], with: .automatic)
        }
    }
}
