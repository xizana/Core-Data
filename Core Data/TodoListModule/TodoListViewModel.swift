//
//  TodoListViewModel.swift
//  Core Data
//
//  Created by Lasha Khizanishvili on 21.03.24.
//

import UIKit

class TodoListViewModel: CRUDOperationable {
    // MARK: - Properties

    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    // MARK: - Functions
    
    func getAllItems(completion: @escaping () -> Void) {
        do {
            guard let items = try context?.fetch(ToDoListItem.fetchRequest()) else { return }
            ModelsData.models = items
            completion()
        }
        catch {
            print("Can not fetch items")
        }
    }
    
    func createItem(name: String, completion: @escaping () -> Void) {
        guard let context = context else { return }
        let newItem = ToDoListItem(context: context)
        newItem.name = name
        newItem.createdAt = Date()
        
        do {
           try context.save()
            completion()
            getAllItems {}
        }
        catch {
            print("Can not create item")
        }
    }
    
    func deleteItem(item: ToDoListItem, completion: @escaping () -> Void) {
        guard let context = context else { return }
        context.delete(item)
        
        do {
           try context.save()
            getAllItems {}
            completion()
        }
        catch {
            print("Can not delete item")
        }
    }
    
    func updateItem(item: ToDoListItem, newName: String, completion: @escaping () -> Void) {
        guard let context = context else { return }
        item.name = newName
        do {
           try context.save()
            getAllItems {}
            completion()
        }
        catch {
            print("Can not update item")
        }
    }
}
