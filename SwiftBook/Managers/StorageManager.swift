//
//  StorageManager.swift
//  TaskList
//
//  Created by Yuri Volegov on 12.06.2023.
//

import Foundation

import CoreData

class StorageManager {
    
    static let shared = StorageManager()
    
    var tasks: [Task] {
        taskList
    }
    
    private var taskList: [Task] = []
    
    private lazy var context = persistentContainer.viewContext
    
    private var newID: Int64 {
        var usedIDs: [Int64] = []
        var result: Int64 = 0
        
        tasks.forEach { task in
            usedIDs.append(task.id)
        }
        
        repeat {
            result = Int64.random(in: 0...10000)
        } while usedIDs.contains(result)
        
        return result
    }
    
    // MARK: - Core Data stack
    
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TaskList")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private init () {
        fetchData { result in
            switch result {
            case .success(let resultTask):
                taskList = resultTask
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - CRUD
    
    func createTask(withTitle title: String) {
        guard let taskEntityDescription = NSEntityDescription.entity(
            forEntityName: "Task",
            in: context
        ) else { return }
        
        let task = Task(entity: taskEntityDescription, insertInto: context)
        task.title = title
        task.id = newID
        saveContext()
        
        DispatchQueue.main.async { [weak self] in
            self?.taskList.append(task)
        }
        
    }
    
    private func fetchData(completion: (Result<[Task], Error>) -> Void) {
        let fetchRequest = Task.fetchRequest()
        
        do {
            let tasks = try context.fetch(fetchRequest)
            completion(.success(tasks))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func fetchTask(withId id: Int) -> Task? {
        tasks.first (where: { $0.id == id })
    }
    
    func fetchTask(withIndex index: Int) -> Task? {
        tasks[index]
    }
    
    func updateTask(with task: Task, newTitle: String) {
        task.title = newTitle
        saveContext()
    }
    
    func updateTask(withId id: Int, newTitle: String) {
        guard let task = tasks.first (where: { $0.id == id }) else { return }
        task.title = newTitle
        saveContext()
    }
    
    func updateTask(withIndex index: Int, newTaskName: String) {
        let task = tasks[index]
        task.title = newTaskName
        saveContext()
    }
    
    func deleteTask(with task: Task) {
        context.delete(task)
        saveContext()
    }
    
    func deleteTask(withId id: Int) {
        guard let task = tasks.first(where: { $0.id == id }) else { return }
        context.delete(task)
        saveContext()
    }
    
    func deleteTask(withIndex index: Int) {
        let task = tasks[index]
        context.delete(task)
        saveContext()
        
        taskList.remove(at: index)
    }
    
    func deleteAllTasks() {
        tasks.forEach { context.delete($0) }
        saveContext()
    }
    
}
