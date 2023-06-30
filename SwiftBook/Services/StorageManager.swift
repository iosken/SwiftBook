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
    
    var taskLists: [TaskList] = [] // stay only shadow task
    
    var shadowTasksCollection: [[TaskShadow]] {
        var result: [[TaskShadow]] = []

        for (index, taskList) in taskLists.enumerated() {
            taskList.tasks.forEach { task in
               // result[index] = []
                result[index].append(
                TaskShadow(
                    title: task.title,
                    note: task.note,
                    date: task.date,
                    isComplete: task.isComplete)
                )
                
                print(index, result[index][0].title)
            }
            //result = [index: Array(_immutableCocoaArray: taskList.tasks)]
        }
        
        print(taskLists.enumerated())
        print("------------------------------------------------------------")
        print(result.first?.first?.title)
        print()
        return result
    }
    
    private let realm = try! Realm()
    
    private lazy var realmTaskLists = realm.objects(TaskList.self)
    
    private init() {
        taskLists = Array(realm.objects(TaskList.self))
    }
    
    // MARK: - Task List
    func completedTasksCount(_ taskList: TaskList) -> Int {
        var result = 0
        taskList.tasks.forEach { task in
            result += task.isComplete ? 1 : 0
        }
        return result
    }
    
    func save(_ taskList: [TaskList]) {
        write {
            realm.add(taskList)
            
            self.taskLists.append(contentsOf: taskList)
        }
    }
    
    func save(_ taskListTitle: String, completion: (TaskList) -> Void) {
        write {
            let taskList = TaskList(value: [taskListTitle])
            realm.add(taskList)
            
            self.taskLists.append(taskList)
            completion(taskList)
        }
    }
    
    func delete(_ taskList: TaskList) {
        write {
            realm.delete(taskList.tasks)
            realm.delete(taskList)
            
            let taskListIndex = taskLists.firstIndex(of: taskList) ?? 0
            taskLists.remove(at: taskListIndex)
        }
    }
    
    func delete(_ task: Task) {
        write {
            realm.delete(task)
            
            taskLists.forEach { taskList in
                if taskList.tasks.contains(task) {
                    let taskIndex = taskList.tasks.firstIndex(of: task) ?? 0
                    taskList.tasks.remove(at: taskIndex)
                }
            }
        }
    }
    
    func edit(_ taskList: TaskList, newTitle: String) {
        write {
            taskList.title = newTitle
        }
        
        let taskListIndex = taskLists.firstIndex(of: taskList) ?? 0
        taskLists[taskListIndex].title = newTitle
    }
    
    func edit(_ task: Task, newTitle: String, newNote: String) {
        write {
            task.title = newTitle
            task.note = newNote
            
            taskLists.forEach { taskList in
                if taskList.tasks.contains(task) {
                    let taskIndex = taskList.tasks.firstIndex(of: task) ?? 0
                    taskList.tasks[taskIndex].title = newTitle
                    taskList.tasks[taskIndex].note = newNote
                }
            }
        }
    }
    
    func done(_ taskList: TaskList) {
        write {
            taskList.tasks.setValue(true, forKey: "isComplete")
        }
        
        let taskListIndex = taskLists.firstIndex(of: taskList) ?? 0
        taskLists[taskListIndex].tasks.forEach { task in
            task.isComplete = true
        }
    }
    
    func done(_ task: Task) {
        write {
            task.setValue(true, forKey: "isComplete")
        }
        
        taskLists.forEach { taskList in
            if taskList.tasks.contains(task) {
                let taskIndex = taskList.tasks.firstIndex(of: task) ?? 0
                taskList.tasks[taskIndex].isComplete = true
            }
        }
    }
    
    func undone(_ taskList: TaskList) {
        write {
            taskList.tasks.setValue(false, forKey: "isComplete")
        }
        
        let taskListIndex = taskLists.firstIndex(of: taskList) ?? 0
        taskLists[taskListIndex].tasks.forEach { task in
            task.isComplete = false
        }
    }
    
    func undone(_ task: Task) {
        write {
            task.setValue(false, forKey: "isComplete")
        }
        
        taskLists.forEach { taskList in
            if taskList.tasks.contains(task) {
                let taskIndex = taskList.tasks.firstIndex(of: task) ?? 0
                taskList.tasks[taskIndex].isComplete = false
            }
        }
        
        //        let currentTaskList = taskLists.first { taskList in
        //            taskList.tasks.contains(task)
        //        } ?? TaskList()
        //
        //        let currentTask = currentTaskList.tasks.first { currentTask in
        //            currentTask === task
        //        }
        //
        //        currentTask?.isComplete = false
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
    
    func shadowToTask(taskShadow: TaskShadow) -> Task {
        var index = 0
        var indexCollection = 0
        
        for (shadowTasksIndex, shadowTasks) in shadowTasksCollection.enumerated() {
            for (indexTask, task) in shadowTasks.enumerated() {
                if task == taskShadow {
                    indexCollection = shadowTasksIndex
                    index = indexTask
                }
            }
        }
        
        return realmTaskLists[indexCollection].tasks[index]
    }
}

extension StorageManager {
    
    func currentTasks(_ taskList: TaskList) -> [TaskShadow] {
        let taskListIndex = taskLists.firstIndex(of: taskList) ?? 999
        print(taskListIndex)
        
        var result: [TaskShadow] = []
        
        result = shadowTasksCollection[taskListIndex].filter { task in
            !task.isComplete
        }
        
        print(result)
        
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
    
    func completedTasks(_ taskList: TaskList) -> [TaskShadow] {
        let taskListIndex = taskLists.firstIndex(of: taskList) ?? 999
        print(taskListIndex)
        
        var result: [TaskShadow] = []
        
        result = shadowTasksCollection[taskListIndex].filter { task in
            task.isComplete
        }
        
        print(result)
        
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
