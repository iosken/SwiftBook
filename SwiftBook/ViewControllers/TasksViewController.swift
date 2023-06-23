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
    var taskListPath: Int!
    
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
        //let task = taskList.tasks[indexPath.row]
        
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
        
        print(task)
        
        if !task.isComplete {
            doneAction = UIContextualAction(style: .normal, title: "Done") { [unowned self] _, _, isDone in
                //tableView.deleteRows(at: [indexPath], with: .automatic)
                let oldTaskList = taskList
                print("currentTasks \(currentTasks) \n\n")
                print("completedTasks \(completedTasks) \n\n")
                print("--------------------------------")
                
                print(indexPath.row)
                storageManager.done(task)
                
                taskList = storageManager.realm.objects(TaskList.self)[taskListPath]
                if oldTaskList == taskList {
                    print("same")
                } else
                {
                   print("not same")
                }
                
                var newRow = 0
                
                print("currentTasks \(currentTasks) \n\n")
                print("completedTasks \(completedTasks) \n\n")
                print("--------------------------------")
                print(task)
                
                
                let newTask = indexPath.section == 0 ? currentTasks[indexPath.row] : completedTasks[indexPath.row]
                
                if let firstIndex = currentTasks.firstIndex(of: newTask) {
                    newRow = firstIndex
                    print("firstIndex \(firstIndex)")
                } else if let newSecondRow = completedTasks.firstIndex(of: newTask) {
                    print("newSecondRow \(newSecondRow)")
                    newRow = newSecondRow
                } else {
                    print("NOTHING")
                }
                
                for currentTask in currentTasks {
                    if task == currentTask {
                        print("same fount \(task)")
                    } else {
                        print("\(currentTask) NOT same \(task)")
                    }
                }
                
                for completeTask in completedTasks {
                    if task == completeTask {
                        print("same fount \(task)")
                    } else {
                        print("\(completeTask) NOT same \(task)")
                    }
                }
                
                let rawIndex = IndexPath(row: newRow, section: 0)
                
                tableView.reloadData()
              //  tableView.reloadRows(at: [rawIndex], with: .automatic)

                isDone(true)
            }
        } else {
            doneAction = UIContextualAction(style: .normal, title: "Undone") { [unowned self] _, _, isDone in
               // tableView.deleteRows(at: [indexPath], with: .automatic)
                print("currentTasks \(currentTasks) \n\n")
                print("completedTasks \(completedTasks) \n\n")
                print("--------------------------------")
                
                print(indexPath.row)
                //storageManager.undone(task)
                
//                currentTasks = taskList.tasks.filter("isComplete = false")
//                completedTasks = taskList.tasks.filter("isComplete = true")
                
//                taskList = realm.objects(TaskList.self)[taskListPath]
                
                let realm = try! Realm()
                try! realm.write {
                    task.setValue(false, forKey: "isComplete")
                }
                
                let newTask = realm.objects(TaskList.self)[taskListPath].tasks[0]
                
                realm.objects(TaskList.self)[taskListPath].tasks.contains(newTask) ? print("CONTAINS") : print("NOT CONTAINS")
                
                for currentTask in taskList.tasks {
                    if task == currentTask {
                        print("same fount \(task)")
                    } else {
                        print("\(currentTask) NOT same \(task)")
                    }
                }
                for completeTask in completedTasks {
                    if task == completeTask {
                        print("same fount \(task)")
                    } else {
                        print("\(completeTask) NOT same \(task)")
                    }
                }
                
                var newRow = 0
                
                if let firstIndex = currentTasks.firstIndex(of: newTask) {
                    newRow = firstIndex
                    print("firstIndex \(firstIndex)")
                } else if let newSecondRow = completedTasks.firstIndex(of: newTask) {
                    print("newSecondRow \(newSecondRow)")
                    newRow = newSecondRow
                } else {
                    print("NOTHING")
                }
    
                print("currentTasks \(currentTasks) /n/n")
                print("completedTasks \(completedTasks) /n/n")
                print(task)
                
                let rawIndex = IndexPath(row: newRow, section: 0)
                
            //    tableView.reloadRows(at: [rawIndex], with: .automatic)
                tableView.reloadData()
                isDone(true)
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
        print(currentTasks.count, completedTasks.count)
        
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
            content.secondaryText = "👍"
        } else {
            content.secondaryText = task.note
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
