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
    
    var shadowTaskLists: [TaskListShadow] = []
    
    private let realm = try! Realm()
    
    private init() {
        let taskLists = Array(realm.objects(TaskList.self))
        
        shadowTaskLists = taskListsToShadow(from: taskLists)
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
        shadowTaskLists.forEach { taskList in
            if taskList.tasks.contains(taskShadow) {
                taskIndex = taskList.tasks.firstIndex(of: taskShadow) ?? 00
            }
        }
        
        return taskIndex
    }
    
    // MARK: - Task List
    func completedTasksCount(_ taskList: TaskListShadow) -> Int {
        var result = 0
        taskList.tasks.forEach { task in
            result += task.isComplete ? 1 : 0
        }
        return result
    }
    
    func save(_ taskList: [TaskList]) {
        write {
            realm.add(taskList)
            
            self.shadowTaskLists.append(contentsOf: taskListsToShadow(from: taskList))
        }
    }
    
    func save(_ taskListTitle: String, completion: (TaskList) -> Void) {
        write {
            let taskList = TaskList(value: [taskListTitle])
            realm.add(taskList)
            
            self.shadowTaskLists.append(
                taskListsToShadow(from: [taskList]).first ?? TaskListShadow()
            )
            completion(taskList)
        }
    }
    
    func delete(_ taskList: TaskList) {
        write {
            realm.delete(taskList.tasks)
            realm.delete(taskList)
            
            let taskListIndex = shadowTaskLists.firstIndex(of: taskListsToShadow(from: [taskList]).first ?? TaskListShadow()) ?? 0
            shadowTaskLists.remove(at: taskListIndex)
        }
    }
    
    func delete(_ task: Task) {
        write {
            realm.delete(task)
            
            let taskShadow = taskToShadow(task: task)
            
            let taskToShadowIndex = taskShadowIndex(taskShadow: taskShadow)
            
            shadowTaskLists.forEach { taskList in
                if taskList.tasks.contains(taskShadow) {
                    let taskIndex = taskList.tasks.firstIndex(of: taskShadow) ?? 0
                    taskList.tasks.remove(at: taskIndex)
                }
            }
        }
    }
    
    func edit(_ taskList: TaskList, newTitle: String) {
        write {
            taskList.title = newTitle
        }
        
        let shadowTaskList = taskListsToShadow(from: [taskList]).first ?? TaskListShadow()
        
        let taskListIndex = shadowTaskLists.firstIndex(of: shadowTaskList) ?? 0
        shadowTaskLists[taskListIndex].title = newTitle
    }
    
    func edit(_ task: Task, newTitle: String, newNote: String) {
        write {
            task.title = newTitle
            task.note = newNote
            
            let shadowTask = taskToShadow(task: task)
            
            shadowTaskLists.forEach { shadowTaskList in
                if shadowTaskList.tasks.contains(shadowTask) {
                    let taskIndex = shadowTaskList.tasks.firstIndex(of: shadowTask) ?? 0
                    shadowTaskList.tasks[taskIndex].title = newTitle
                    shadowTaskList.tasks[taskIndex].note = newNote
                }
            }
        }
    }
    
    func done(_ taskList: TaskList) {
        write {
            taskList.tasks.setValue(true, forKey: "isComplete")
        }
        
        let taskListShadow = taskListsToShadow(from: [taskList]).first ?? TaskListShadow()
        
        let taskListIndex = shadowTaskLists.firstIndex(of: taskListShadow) ?? 0
        shadowTaskLists[taskListIndex].tasks.forEach { task in
            task.isComplete = true
        }
    }
    
    func done(_ task: Task) {
        write {
            task.setValue(true, forKey: "isComplete")
        }
        
        let shadowTask = taskToShadow(task: task)
        
        shadowTaskLists.forEach { shadowTaskList in
            if shadowTaskList.tasks.contains(shadowTask) {
                let taskIndex = shadowTaskList.tasks.firstIndex(of: shadowTask) ?? 0
                shadowTaskList.tasks[taskIndex].isComplete = true
            }
        }
    }
    
    func undone(_ taskList: TaskList) {
        write {
            taskList.tasks.setValue(false, forKey: "isComplete")
        }
        
        let shadowTaskList = taskListsToShadow(from: [taskList]).first ?? TaskListShadow()
        
        let taskListIndex = shadowTaskLists.firstIndex(of: shadowTaskList) ?? 0
        shadowTaskLists[taskListIndex].tasks.forEach { task in
            task.isComplete = false
        }
    }
    
    func undone(_ task: Task) {
        write {
            task.setValue(false, forKey: "isComplete")
        }
        
        let shadowTask = taskToShadow(task: task)
        
        shadowTaskLists.forEach { shadowTaskList in
            if shadowTaskList.tasks.contains(shadowTask) {
                let taskIndex = shadowTaskList.tasks.firstIndex(of: shadowTask) ?? 0
                shadowTaskList.tasks[taskIndex].isComplete = false
            }
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
    
//    func shadowToTask(taskShadow: TaskShadow) -> Task {
//        var index = 0
//        var indexCollection = 0
//
//        for (shadowTasksIndex, shadowTasks) in shadowTasksCollection.enumerated() {
//            for (indexTask, task) in shadowTasks.enumerated() {
//                if task == taskShadow {
//                    indexCollection = shadowTasksIndex
//                    index = indexTask
//                }
//            }
//        }
//
//        return realmTaskLists[indexCollection].tasks[index]
//    }
}

extension StorageManager {
    
    func currentTasks(_ taskListShadow: TaskListShadow) -> [TaskShadow] {
        let taskListShadowIndex = shadowTaskLists.firstIndex(of: taskListShadow) ?? 999
        
        var result: [TaskShadow] = []
        
        result = shadowTaskLists[taskListShadowIndex].tasks.filter { task in
            !task.isComplete
        }
        
        switch taskListsSortingMethod {
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
        let taskListShadowIndex = shadowTaskLists.firstIndex(of: taskListShadow) ?? 999
        
        var result: [TaskShadow] = []
        
        result = shadowTaskLists[taskListShadowIndex].tasks.filter { task in
            task.isComplete
        }
        
        switch taskListsSortingMethod {
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





//        taskLists = realm.objects(TaskList.self) {
//            switch taskListsSortingMethod {
//            case .date:
//                return Array(
//                    realm.objects(TaskList.self).sorted(
//                        byKeyPath: "date",
//                        ascending: true
//                    )
//                )
//            default:
//                return Array(
//                    realm.objects(TaskList.self).sorted(
//                        byKeyPath: "title",
//                        ascending: true)
//                )
//            }
//        }()
