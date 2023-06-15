//
//  Photo+CoreDataProperties.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 14.06.2023.
//
//

import Foundation
import CoreData

@objc(Photo)
public class Photo: NSManagedObject {}

extension Photo {

//    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
//        return NSFetchRequest<Photo>(entityName: "Photo")
//    }

    @NSManaged public var id: Int64
    @NSManaged public var url: String?
    @NSManaged public var title: String

}

extension Photo : Identifiable {}
