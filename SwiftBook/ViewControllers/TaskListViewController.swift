//
//  TaskListViewController.swift
//  TaskList
//
//  Created by Yuri Volegov on 08.06.2023.
//

import UIKit

final class TaskListViewController: UITableViewController {
    
    private let cellID = "task"
    
    private var taskList: [Task] = []
    
    private let data = StorageManager.shared
    private let alert = AlertManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        view.backgroundColor = .white
        
        setupNavigationBar()
        taskList = data.tasks
    }
    
    private func setupNavigationBar() {
        title = "Task List"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = UIColor(
            red: 21/255,
            green: 101/255,
            blue: 192/255,
            alpha: 194/255
        )
        
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewTask)
        )
        
        navigationController?.navigationBar.tintColor = .white
    }
    
    @objc private func addNewTask() {
        alert.showAlert(from: self, status: .save) { [weak self] task in
            self?.save(task)
        }
    }
    
    private func save(_ taskName: String) {
        let newTask = data.createTask(title: taskName)
        
        taskList.append(newTask)
        
        let cellIndex = IndexPath(row: taskList.count - 1, section: 0)
        tableView.insertRows(at: [cellIndex], with: .automatic)
    }
    
    private func delete(index: Int) {
        data.deleteTask(index: index)
        
        taskList.remove(at: index)
        
        let cellIndex = IndexPath(row: index, section: 0)
        tableView.deleteRows(at: [cellIndex], with: .automatic)
    }
    
    private func reload(index: Int, newTaskName: String) {
        data.updateTasks(withIndex: index, newTaskName: newTaskName)
        
        let cellIndex = IndexPath(row: index, section: 0)
        tableView.reloadRows(at: [cellIndex], with: .automatic)
    }
    
}

// MARK: - TableView DataSource and Delegate

extension TaskListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let task = taskList[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = task.title
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        alert.showAlert(from: self, status: .update) { [weak self] task in
//            self?.reload(index: indexPath.row, newTaskName: task)
//        }
        
        alert.showAlert(from: self, status: .update) { [weak self] task in
            self?.data.updateTasks(withIndex: indexPath.row, newTaskName: task)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            delete(index: indexPath.row)
        }
        taskList.remove(at: indexPath.row)
    }
    
}
