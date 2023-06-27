//
//  StorageManager.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 20.06.2023.
//

import Foundation
import RealmSwift

enum TaskListProperty {
    case date
    case title
}

final class StorageManager {
    static let shared = StorageManager()
    
    var taskListsSortingMethod = TaskListProperty.date
    
    var taskLists: [TaskList] {
        switch taskListsSortingMethod {
        case .date:
            return Array(realm.objects(TaskList.self).sorted(byKeyPath: "date", ascending: true))
        default:
            return Array(realm.objects(TaskList.self).sorted(byKeyPath: "title", ascending: true))
        }
    }
    
    private let realm = try! Realm()
    
    private lazy var realmTaskLists = realm.objects(TaskList.self)
    
    private init() {}
    
    // MARK: - Task List
    func completedTasksCount(_ taskList: TaskList) -> Int {
        var result = 0
        taskList.tasks.forEach { task in
            result += task.isComplete ? 1 : 0
        }
        return result
    }
    
    func save(_ taskLists: [TaskList]) {
        write {
            realm.add(taskLists)
        }
    }
    
    func save(_ taskListTitle: String, completion: (TaskList) -> Void) {
        write {
            let taskList = TaskList(value: [taskListTitle])
            realm.add(taskList)
            completion(taskList)
        }
    }
    
    func delete(_ taskList: TaskList) {
        write {
            realm.delete(taskList.tasks)
            realm.delete(taskList)
        }
    }
    
    func delete(_ task: Task) {
        write {
            realm.delete(task)
        }
    }
    
    func edit(_ taskList: TaskList, newTitle: String) {
        write {
            taskList.title = newTitle
        }
    }
    
    func edit(_ task: Task, newTitle: String, newNote: String) {
        write {
            task.title = newTitle
            task.note = newNote
        }
    }
    
    func done(_ taskList: TaskList) {
        write {
            taskList.tasks.setValue(true, forKey: "isComplete")
        }
    }
    
    func done(_ task: Task) {
        write {
            task.setValue(true, forKey: "isComplete")
        }
    }
    
    func undone(_ taskList: TaskList) {
        write {
            taskList.tasks.setValue(false, forKey: "isComplete")
        }
    }
    
    func undone(_ task: Task) {
        write {
            task.setValue(false, forKey: "isComplete")
        }
    }
    
    
    
    // MARK: - Tasks
    func save(_ taskTitle: String, withTaskNote taskNote: String, to taskList: TaskList, completion: (Task) -> Void) {
        write {
            let task = Task(value: [taskTitle, taskNote])
            taskList.tasks.append(task)
            
            completion(task)
        }
    }
    
    private func write(completion: () -> Void) {
        do {
            try realm.write {
                completion()
            }
        } catch {
            print(error.localizedDescription)
        }
        
    }
}

extension StorageManager {
    
    func currentTasks(_ taskList: TaskList) -> [Task] {
        switch taskListsSortingMethod {
        case .date:
            return Array(taskList.tasks.filter("isComplete = false").sorted(byKeyPath: "date", ascending: true))
        default:
            return Array(taskList.tasks.filter("isComplete = false").sorted(byKeyPath: "title", ascending: true))
        }
    }
    
    func completedTasks(_ taskList: TaskList) -> [Task] {
        switch taskListsSortingMethod {
        case .date:
            return Array(taskList.tasks.filter("isComplete = true").sorted(byKeyPath: "date", ascending: true))
        default:
            return Array(taskList.tasks.filter("isComplete = true").sorted(byKeyPath: "title", ascending: true))
        }
    }
    
}
