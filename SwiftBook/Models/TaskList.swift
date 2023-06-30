//
//  TaskList.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 20.06.2023.
//

import RealmSwift
import Foundation

class TaskList: Object {
    @Persisted var title = ""
    @Persisted var date = Date()
    @Persisted var tasks = List<Task>()
    
    //    init(title: String = "", date: Date = Date(), tasks: List<Task> = List<Task>()) {
    //        self.title = title
    //        self.date = date
    //        self.tasks = tasks
    //    }
}

class Task: Object {
    @Persisted var title = ""
    @Persisted var note = ""
    @Persisted var date = Date()
    @Persisted var isComplete = false
}

class TaskShadow {
    var title: String
    var note: String
    var date: Date
    var isComplete: Bool
    
//    init() {
//    title = ""
//    note = ""
//    date = Date()
//    isComplete = false
//    }
    
    init(title: String = "",
         note: String = "",
         date: Date = Date(),
         isComplete: Bool = false
    ) {
        self.title = title
        self.note = note
        self.date = date
        self.isComplete = isComplete
    }
}

extension TaskShadow: Equatable {
    static func == (lhs: TaskShadow, rhs: TaskShadow) -> Bool {
        var result = false
        
        if lhs.isComplete == rhs.isComplete &&
            lhs.date == rhs.date &&
            lhs.note == rhs.note &&
            lhs.title == rhs.title {
            result = true
        }
        
        return result
    }
}


