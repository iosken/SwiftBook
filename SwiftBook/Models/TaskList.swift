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
}

class Task: Object {
    @Persisted var title = ""
    @Persisted var note = ""
    @Persisted var date = Date()
    @Persisted var isComplete = false
}

class TaskListShadow {
    var title = ""
    var date = Date()
    var tasks: [TaskShadow] = []
    
    init() {
        title = ""
        date = Date()
        tasks = []
    }
    
    init(
        title: String,
         date: Date,
         tasks: [TaskShadow]
    ) {
        self.title = title
        self.date = date
        self.tasks = tasks
    }
}

class TaskShadow {
    var title: String
    var note: String
    var date: Date
    var isComplete: Bool
    
    init() {
     title = ""
     note = ""
     date = Date()
     isComplete = false
    }
    
    init(
        title: String,
         note: String,
         date: Date,
         isComplete: Bool
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

extension TaskListShadow: Equatable {
    static func == (lhs: TaskListShadow, rhs: TaskListShadow) -> Bool {
        var result = false
        
        if lhs.title == rhs.title &&
            lhs.date == rhs.date {
            result = true
        }
        
        return result
    }
    
    
}


