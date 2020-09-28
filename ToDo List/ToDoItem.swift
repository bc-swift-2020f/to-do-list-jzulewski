//
//  ToDoItem.swift
//  ToDo List
//
//  Created by John Zulewski on 9/28/20.
//

import Foundation

struct ToDoItem: Codable {
    var name: String
    var date: Date
    var notes: String
    var reminderSet: Bool
}
