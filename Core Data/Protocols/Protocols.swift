//
//  Protocols.swift
//  Core Data
//
//  Created by Lasha Khizanishvili on 20.03.24.
//

import Foundation

protocol CRUDOperationable {
    func getAllItems(completion: @escaping () -> Void)
    func createItem(name: String, completion: @escaping () -> Void)
    func deleteItem(item: ToDoListItem, completion: @escaping () -> Void)
    func updateItem(item: ToDoListItem, newName: String, completion: @escaping () -> Void)
}
