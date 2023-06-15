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
    
    private init () {}
    
    // MARK: - Core Data stack
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TaskList")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
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
    
    private lazy var context = persistentContainer.viewContext
    
    func createTask(_ id: Int, title: String) -> Task {
        guard let taskEntityDescription = NSEntityDescription.entity(forEntityName: "Task", in: context) else { return Task() }
        let task = Task(entity: taskEntityDescription, insertInto: context)
        task.title = title
        task.id = Int64(id)
        
        saveContext()
        return task
    }
    
    func fetchTasks() -> [Task] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        
        do {
            return (try? context.fetch(fetchRequest) as? [Task]) ?? []
        }
    }
    
    func fetchTask(_ id: Int) -> Task? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        
        do {
            let tasks = try? context.fetch(fetchRequest) as? [Task]
            
            return tasks?.first (where: { $0.id == id })
        }
    }
    
    func updateTasks(with id: Int, newUrl: String, title: String? = nil) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        
        do {
            guard let tasks = try? context.fetch(fetchRequest) as? [Task],
                  let task = tasks.first (where: { $0.id == id }) else { return }
            
            task.title = title ?? ""
        }
        
        saveContext()
    }
    
    func deleteAllTasks() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        
        do {
            let tasks = try? context.fetch(fetchRequest) as? [Task]
            tasks?.forEach { context.delete($0) }
        }
        
        saveContext()
    }
    
    func deleteTask(id: Int) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        
        do {
            guard let tasks = try? context.fetch(fetchRequest) as? [Task],
                  let task = tasks.first(where: { $0.id == id }) else { return }
            context.delete(task)
        }
        
        saveContext()
    }
    
    func deleteTask(index: Int) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        
        do {
            guard let tasks = try? context.fetch(fetchRequest) as? [Task] else { return }
            
            let task = tasks[index]
            context.delete(task)
        }
        
        saveContext()
    }
    
}
