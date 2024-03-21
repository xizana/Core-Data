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
        
    }
    
    func deleteItem(item: ToDoListItem) {
        
    }
    
    func updateItem(item: ToDoListItem) {
        
    }
    
}

