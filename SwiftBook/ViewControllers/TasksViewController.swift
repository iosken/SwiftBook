//
//  TasksViewController.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 20.06.2023.
//

import UIKit
import RealmSwift

final class TasksViewController: UITableViewController {
    
    private let data = StorageManager.shared
    private let alert = AlertManager.shared
    
    var taskList: TaskList!
    
    var currentTasks: [Task] {
        data.currentTasks(taskList)
    }
    
    var completedTasks: [Task] {
        data.completedTasks(taskList)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = taskList.title
        
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonPressed)
        )
        navigationItem.rightBarButtonItems = [addButton, editButtonItem]

    }
    
    // MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let task = indexPath.section == 0 ? currentTasks[indexPath.row] : completedTasks[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [unowned self] _, _, _ in
            data.delete(task)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { [unowned self] _, _, isDone in
            alert.showAlert(presentIn: self, task: task) { [weak self] title, note in
                self?.data.edit(task, newTitle: title, newNote: note)
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            
            isDone(true)
        }
        
        var doneAction = UIContextualAction()
        
        if !task.isComplete {
            doneAction = UIContextualAction(style: .normal, title: "Done") { [unowned self] _, _, isDone in
                isDone(true)
                
                data.done(task)

                let rowToInsert = currentTasks.firstIndex(of: task) ?? 0
                
                tableView.performBatchUpdates(
                    {
                        tableView.deleteRows(at: [indexPath], with: .automatic)
                        tableView.insertRows(at: [IndexPath(row: rowToInsert, section: 1)], with: .automatic)
                    }, completion: nil
                )
            }
        } else {
            doneAction = UIContextualAction(style: .normal, title: "Undone") { [unowned self] _, _, isDone in
                isDone(true)
                data.undone(task)
                let rowToInsert = completedTasks.firstIndex(of: task) ?? 0
                
                tableView.performBatchUpdates(
                    {
                        tableView.deleteRows(at: [indexPath], with: .automatic)
                        tableView.insertRows(at: [IndexPath(row: rowToInsert, section: 0)], with: .automatic)
                    }, completion: nil
                )
            }
        }
        editAction.backgroundColor = .orange
        doneAction.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        
        return UISwipeActionsConfiguration(actions: [doneAction, editAction, deleteAction])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = indexPath.section == 0 ? currentTasks[indexPath.row] : completedTasks[indexPath.row]
        
        alert.showAlert(presentIn: self, task: task) { [weak self] title, note in
            self?.data.edit(task, newTitle: title, newNote: note)
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
        
        content.secondaryText = task.note
        
        if task.isComplete {
            content.image = UIImage(systemName: "checkmark")
        } else {
            content.image = UIImage(systemName: "xmark")
        }
        
        cell.contentConfiguration = content
        return cell
    }
    
    @objc private func addButtonPressed() {
        alert.showAlert(        presentIn: self, task: nil) { [weak self] task, note in
            self?.save(task: task, withNote: note)
        }
    }
    
}

extension TasksViewController {
    private func save(task: String, withNote note: String) {
        data.save(task, withTaskNote: note, to: taskList) { task in
            
            let section = !task.isComplete ? 0 : 1
            let row = !task.isComplete ? currentTasks.firstIndex(of: task) : completedTasks.firstIndex(of: task)
            
            let rowIndex = IndexPath(row: row ?? 0, section: section)
            
            tableView.insertRows(at: [rowIndex], with: .automatic)
        }
    }
}
