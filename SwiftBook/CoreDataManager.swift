//
//  CoreDataManager.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 14.06.2023.
//

import Foundation
import CoreData

// MARK: - CRUD

public final class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}
    
    func logCoreDataDBPath() {
        if let url = persistentContainer.persistentStoreCoordinator.persistentStores.first?.url {
            print("DB url - \(url)")
        }
    }
    
    // MARK: - Core Data stack
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            } else {
                print("DB url -", storeDescription.url?.absoluteString ?? "")
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
    
    private lazy var context = persistentContainer.viewContext
    
    func createPhoto(_ id: Int64, title: String, url: String?) {
        guard let photoEntityDescription = NSEntityDescription.entity(forEntityName: "Photo", in: context) else { return }
        let photo = Photo(entity: photoEntityDescription, insertInto: context)
        photo.id = id
        photo.title = title
        photo.url = url
        
        saveContext()
    }
    
    func fetchPhotos() -> [Photo] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        
        do {
            return (try? context.fetch(fetchRequest) as? [Photo]) ?? []
        }
        
        //        do {
        //            return try context.fetch(fetchRequest) as! [Photo]
        //        } catch {
        //            print(error.localizedDescription)
        //        }
        //
        //        return []
    }
    
    func fetchPhotos(_ id: Int64) -> Photo? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        // fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let photos = try? context.fetch(fetchRequest) as? [Photo]
            
            return photos?.first (where: { $0.id == id })
        }
        
    }
    
    func updatePhoto(with id: Int64, newUrl: String, title: String? = nil) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        // fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            guard let photos = try? context.fetch(fetchRequest) as? [Photo],
                  let photo = photos.first (where: { $0.id == id }) else { return }
            
            photo.url = newUrl
            photo.title = title ?? ""
        }
        
        saveContext()
    }
    
    func deleteAllPhoto() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        
        do {
            let photos = try? context.fetch(fetchRequest) as? [Photo]
            photos?.forEach { context.delete($0) }
        }
        
        saveContext()
    }
    
    func deletePhoto(with id: Int64) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        // fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            guard let photos = try? context.fetch(fetchRequest) as? [Photo],
                  let photo = photos.first (where: { $0.id == id }) else { return }
            context.delete(photo)
        }
        
        saveContext()
    }
    
}

