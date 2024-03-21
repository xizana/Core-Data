//
//  ViewController.swift
//  Core Data
//
//  Created by Lasha Khizanishvili on 20.03.24.
//

import UIKit

class TodoListViewController: UIViewController, CRUDOperationable {
    
    // MARK: - Properties
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    // MARK: - Functions
    
    func getAllItems() {
        do {
            let items = try context?.fetch(ToDoListItem.fetchRequest())
        }
        catch {
            print("Can not fetch items")
        }
    }
    
    func createItem(name: String) {
        guard let context = context else { return }
        let newItem = ToDoListItem(context: context)
        newItem.name = name
        newItem.createdAt = Date()
        
        do {
           try context.save()
        }
        catch {
            print("Can not create item")
        }
    }
    
    func deleteItem(item: ToDoListItem) {
        guard let context = context else { return }
        context.delete(item)
        
        do {
           try context.save()
        }
        catch {
            print("Can not delete item")
        }
    }
    
    func updateItem(item: ToDoListItem, newName: String) {
        guard let context = context else { return }
        context.name = newName
        do {
           try context.save()
        }
        catch {
            print("Can not update item")
        }
    }
    
}

