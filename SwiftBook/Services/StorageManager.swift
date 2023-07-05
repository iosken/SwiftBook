//
//  StorageManager.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 20.06.2023.
//

import Foundation
import RealmSwift

enum SortMethod {
    case date
    case title
}

final class StorageManager {
    
    static let shared = StorageManager()
    
    var taskListSortMethod = SortMethod.date
    
    var taskListsShadow: [TaskListShadow] = []
    
    private let taskLists: Results<TaskList>
    
    private let realm = try! Realm()
    
    private init() {
        self.taskLists = realm.objects(TaskList.self)
        
        taskListsShadow = taskListsToShadow(from: Array(taskLists)).sorted { lhs, rhs in
            lhs.date > rhs.date
        }
    }
    
    func completedTasksCount(_ taskListShadow: TaskListShadow) -> Int {
        taskListShadow.tasks.filter { task in
            task.isComplete
        }.count
    }
    
    func taskListsToShadow(from taskLists: [TaskList]) -> [TaskListShadow] {
        var taskListShadow: [TaskListShadow] = []
        for taskList in taskLists {
            let tasks = {
                var result: [TaskShadow] = []
                taskList.tasks.forEach { task in
                    result.append(
                        taskToShadow(task: task)
                    )
                }
                
                return result
            }()
            
            taskListShadow.append(TaskListShadow(
                title: taskList.title,
                date: taskList.date,
                tasks: tasks
            ))
            
        }
        return taskListShadow
    }
    
    func shadowToTaskList(from taskListsShadow: TaskListShadow) -> TaskList {
        var result: TaskList
        
        result = taskLists.filter(
            "title = '\(taskListsShadow.title)'",
            "date = \(taskListsShadow.date)"
        ).first ?? TaskList()
        
        return result
    }
    
    func initTaskList(from taskListsShadow: [TaskListShadow]) -> [TaskList] {
        var taskList: [TaskList] = []
        for taskListShadow in taskListsShadow {
            let tasks = {
                var result: [Task] = []
                taskListShadow.tasks.forEach { taskShadow in
                    result.append(shadowToTask(taskShadow: taskShadow))
                }
                
                return result
            }()
            
            taskList.append(TaskList(
                value: [
                    taskListShadow.title,
                    taskListShadow.date,
                    tasks] as [Any]
            )
            )
        }
        
        return taskList
    }
    
    func initTask(from taskShadow: TaskShadow) -> Task {
        Task(value: [
            taskShadow.title,
            taskShadow.note,
            taskShadow.date,
            taskShadow.isComplete
        ] as [Any])
    }
    
    func shadowToTask(taskShadow: TaskShadow) -> Task {
        var result = Task()
        
        taskLists.forEach { taskList in
            let task = taskList.tasks.filter(
                "title = '\(taskShadow.title)'",
                "note = '\(taskShadow.note)'",
                "date = \(taskShadow.date)",
                "isComplete = \(taskShadow.isComplete)"
            )
            
            if !task.isEmpty {
                result = task.first ?? Task()
            }
        }
        
        return result
    }
    
    func taskToShadow(task: Task) -> TaskShadow {
        TaskShadow(
            title: task.title,
            note: task.note,
            date: task.date,
            isComplete: task.isComplete
        )
    }
    
    func taskShadowIndex(taskShadow: TaskShadow) -> Int {
        var taskIndex = 0
        taskListsShadow.forEach { taskList in
            if taskList.tasks.contains(taskShadow) {
                taskIndex = taskList.tasks.firstIndex(of: taskShadow) ?? 00
            }
        }
        
        return taskIndex
    }
    
    // MARK: - Task List
    func save(_ taskListsShadow: [TaskListShadow]) {
        let taskLists = initTaskList(from: taskListsShadow)
        
        write {
            realm.add(taskLists)
        }
        
        self.taskListsShadow.append(contentsOf: taskListsShadow)
    }
    
    func save(_ taskListTitle: String, completion: (TaskListShadow) -> Void) {
        let taskList = TaskList(value: [taskListTitle])
        let taskListShadow = taskListsToShadow(from: [taskList]).first ?? TaskListShadow()
    
        write {
            realm.add(taskList)
        }
        
        self.taskListsShadow.append(taskListShadow)
        
        completion(taskListShadow)
    }
    
    func delete(_ taskListShadow: TaskListShadow) {
        let taskList = shadowToTaskList(from: taskListShadow)
        let tasks = taskList.tasks
        
        write {
            realm.delete(tasks)
            realm.delete(taskList)
        }
        
        let taskListIndex = taskListsShadow.firstIndex(of: taskListShadow) ?? 99
        taskListsShadow.remove(at: taskListIndex)
    }
    
    func delete(_ taskShadow: TaskShadow) {
        let task = shadowToTask(taskShadow: taskShadow)
        
        write {
            realm.delete(task)
        }
        
        taskListsShadow.forEach { taskList in
            if taskList.tasks.contains(taskShadow) {
                let taskIndex = taskList.tasks.firstIndex(of: taskShadow) ?? 0
                taskList.tasks.remove(at: taskIndex)
            }
        }
    }
    
    func edit(_ taskListShadow: TaskListShadow, newTitle: String) {
        let taskList: TaskList = shadowToTaskList(from: taskListShadow)
        
        write {
            taskList.title = newTitle
        }
        
        let taskListIndex = taskListsShadow.firstIndex(of: taskListShadow) ?? 0
        taskListsShadow[taskListIndex].title = newTitle
    }
    
    func edit(_ taskShadow: TaskShadow, newTitle: String, newNote: String) {
        let task = shadowToTask(taskShadow: taskShadow)
        
        write {
            task.title = newTitle
            task.note = newNote
        }
        
        taskListsShadow.forEach { shadowTaskList in
            if shadowTaskList.tasks.contains(taskShadow) {
                let taskIndex = shadowTaskList.tasks.firstIndex(of: taskShadow) ?? 0
                shadowTaskList.tasks[taskIndex].title = newTitle
                shadowTaskList.tasks[taskIndex].note = newNote
            }
        }
    }
    
    func done(_ taskListShadow: TaskListShadow) {
        let taskList = shadowToTaskList(from: taskListShadow)
        
        write {
            taskList.tasks.setValue(true, forKey: "isComplete")
        }
        
        let taskListIndex = taskListsShadow.firstIndex(of: taskListShadow) ?? 0
        taskListsShadow[taskListIndex].tasks.forEach { task in
            task.isComplete = true
        }
    }
    
    func done(_ taskShadow: TaskShadow) {
        let task = shadowToTask(taskShadow: taskShadow)
        
        write {
            task.setValue(true, forKey: "isComplete")
        }
        
        taskListsShadow.forEach { shadowTaskList in
            if shadowTaskList.tasks.contains(taskShadow) {
                let taskIndex = shadowTaskList.tasks.firstIndex(of: taskShadow) ?? 0
                shadowTaskList.tasks[taskIndex].isComplete = true
            }
        }
    }
    
    func undone(_ taskListShadow: TaskListShadow) {
        let taskList: TaskList = shadowToTaskList(from: taskListShadow)
        
        write {
            taskList.tasks.setValue(false, forKey: "isComplete")
        }
        
        let taskListIndex = taskListsShadow.firstIndex(of: taskListShadow) ?? 0
        taskListsShadow[taskListIndex].tasks.forEach { task in
            task.isComplete = false
        }
    }
    
    func undone(_ taskShadow: TaskShadow) {
        let task = shadowToTask(taskShadow: taskShadow)
        
        write {
            task.setValue(false, forKey: "isComplete")
        }
        
        taskListsShadow.forEach { taskListShadow in
            if taskListShadow.tasks.contains(taskShadow) {
                let taskIndex = taskListShadow.tasks.firstIndex(of: taskShadow) ?? 0
                taskListShadow.tasks[taskIndex].isComplete = false
            }
        }
    }
    
    // MARK: - Tasks
    
    func save(_ taskTitle: String, withTaskNote taskNote: String, to taskListShadow: TaskListShadow, completion: (TaskShadow) -> Void) {
        let taskList: TaskList = shadowToTaskList(from: taskListShadow)
        let task = Task(value: [taskTitle, taskNote])
        
        write {
            taskList.tasks.append(task)
        }
        
        let taskShadow = TaskShadow(
            title: taskTitle,
            note: taskNote,
            date: Date(),
            isComplete: false
        )
        
        taskListShadow.tasks.append(taskShadow)
        
        completion(taskShadow)
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
    
    func currentTasks(_ taskListShadow: TaskListShadow) -> [TaskShadow] {
        let taskListShadowIndex = taskListsShadow.firstIndex(of: taskListShadow) ?? 999
        
        var result: [TaskShadow] = []
        
        result = taskListsShadow[taskListShadowIndex].tasks.filter { task in
            !task.isComplete
        }
        
        switch taskListSortMethod {
        case .date:
            return result.sorted { lhs, rhs in
                lhs.date > rhs.date
            }
        default:
            return result.sorted { lhs, rhs in
                lhs.title > rhs.title
            }
        }
    }
    
    func completedTasks(_ taskListShadow: TaskListShadow) -> [TaskShadow] {
        let taskListShadowIndex = taskListsShadow.firstIndex(of: taskListShadow) ?? 999
        
        var result: [TaskShadow] = []
        
        result = taskListsShadow[taskListShadowIndex].tasks.filter { task in
            task.isComplete
        }
        
        switch taskListSortMethod {
        case .date:
            return result.sorted { lhs, rhs in
                lhs.date > rhs.date
            }
        default:
            return result.sorted { lhs, rhs in
                lhs.title > rhs.title
            }
        }
    }
    
}
