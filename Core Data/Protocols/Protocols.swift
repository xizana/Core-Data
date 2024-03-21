//
//  Protocols.swift
//  Core Data
//
//  Created by Lasha Khizanishvili on 20.03.24.
//

import Foundation

protocol CRUDOperationable {
    func getAllItems()
    func createItem(name: String)
    func deleteItem(item: ToDoListItem)
    func updateItem(item: ToDoListItem, newName: String)
}
