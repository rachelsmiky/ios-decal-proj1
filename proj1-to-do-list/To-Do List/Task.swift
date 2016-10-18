//
//  Task.swift
//  To-Do List
//
//  Created by Rachel Song on 10/15/16.
//  Copyright © 2016 Rachel Song. All rights reserved.
//

import Foundation
class Task {
    // MARK: Properties
    
    var name: String = ""
    var details: String?
    var timestamp: NSDate!
    var completed: Bool!
    
    init?(name: String, details: String?) {
        self.name = name
        self.details = details
        self.timestamp = NSDate()
        self.completed = false
        
        if name.isEmpty {
            return nil
        }
    }
}
