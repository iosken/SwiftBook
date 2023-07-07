//
//  TaskListViewController.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 20.06.2023.
//

import UIKit
import RealmSwift

final class TaskListViewController: UITableViewController {
    
    private let data = StorageManager.shared
    private let alert = AlertManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonPressed)
        )
        
        navigationItem.rightBarButtonItem = addButton
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.title = "Task List"
        createTempData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.taskListsShadow.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let result = tableView.dequeueReusableCell(withIdentifier: "TaskListCell", for: indexPath)
        var content = result.defaultContentConfiguration()
        let taskList = data.taskListsShadow[indexPath.row]
        content.text = taskList.title
        
        let completedTasksCount = data.completedTasksCount(taskList)
        
        if taskList.tasks.isEmpty{
            content.secondaryText = "-"
        } else if completedTasksCount == taskList.tasks.count {
            content.secondaryTextProperties.color = UIColor(.blue)
            content.secondaryText = "⎷"
        } else {
            content.secondaryTextProperties.color = UIColor(.gray)
            content.secondaryText = completedTasksCount.formatted()
        }
        
        result.contentConfiguration = content
        return result
    }
    
    // MARK: - Table View Data Source
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let taskListShadow = data.taskListsShadow[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [unowned self] _, _, _ in
            data.delete(taskListShadow)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { [unowned self] _, _, isDone in
            alert.showAlert(presentIn: self, taskListShadow: taskListShadow) { taskListValue in
                self.data.edit(taskListShadow, newTitle: taskListValue)
            }
            tableView.reloadRows(at: [indexPath], with: .automatic)
            isDone(true)
        }
        
        let doneAction = UIContextualAction(style: .normal, title: "Done") { [unowned self] _, _, isDone in
            data.done(taskListShadow)
            tableView.reloadRows(at: [indexPath], with: .automatic)
            isDone(true)
        }
        
        editAction.backgroundColor = .orange
        doneAction.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        
        return UISwipeActionsConfiguration(actions: [doneAction, editAction, deleteAction])
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        guard let tasksVC = segue.destination as? TasksViewController else { return }
        let taskListShadow = data.taskListsShadow[indexPath.row]
        tasksVC.taskListShadow = taskListShadow
    }
    
    @IBAction func sortingList(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            data.taskListSortMethod == .dateDown ?
            (data.taskListSortMethod = .titleDown) :
            (data.taskListSortMethod = .titleUp)
        } else {
            data.taskListSortMethod == .titleUp ?
            (data.taskListSortMethod = .dateDown) :
            (data.taskListSortMethod = .dateUp)
        }
        
        tableView.reloadData()
    }
    
    @objc private func addButtonPressed() {
        alert.showAlert(presentIn: self, taskListShadow: nil) { [weak self] task in
            self?.save(task)
        }
    }
    
    private func createTempData() {
        if !UserDefaults.standard.bool(forKey: "done") {
            DataManager.shared.createTempData { [unowned self] in
                UserDefaults.standard.set(true, forKey: "done")
                tableView.reloadData()
            }
        }
    }
}

// MARK: - AlertController

extension TaskListViewController {
    
    private func save(_ taskListTitle: String) {
        data.save(taskListTitle) { [weak self] taskListShadow in
            let indexRow = self?.data.taskListsShadow.firstIndex(of: taskListShadow) ?? 0
            let indexPath = IndexPath(row: indexRow, section: 0)
            
            print(indexPath)
            
            self?.tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
}
