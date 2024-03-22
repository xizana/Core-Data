//
//  ViewController.swift
//  Core Data
//
//  Created by Lasha Khizanishvili on 20.03.24.
//

import UIKit
import Combine

class TodoListViewController: UIViewController {
    
    // MARK: - Properties
    private var subscriptions = Set<AnyCancellable>()
    
    private let todoListView: TodoListView
    private let todoListVM: TodoListViewModel
    
    init(todoListView: TodoListView = TodoListView(), todoListVM: TodoListViewModel = TodoListViewModel()) {
        self.todoListView = todoListView
        self.todoListVM = todoListVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = todoListView
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTappedAdd))
        
        todoListVM.getAllItems {
            DispatchQueue.main.async {
                self.todoListView.tableView.reloadData()
            }
        }
        
        sheetActions()
    }
    
    // MARK: - Functions
    
    @objc private func didTappedAdd() {
        let alert =  UIAlertController(title: "New Items", message: "Enter New Item", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { [weak self] _ in
            guard let field = alert.textFields?.first,
                  let text = field.text, !text.isEmpty else { return }
            self?.todoListVM.createItem(name: text) {
                DispatchQueue.main.async {
                    self?.todoListView.tableView.reloadData()
                }
            }
        }))
        present(alert, animated: true)
    }
    
    
    func sheetActions() {
        todoListView.$selectedItemIndex
            .sink { newVal in
                guard let index = newVal else { return }
                let item = ModelsData.models[index]
                let sheet = UIAlertController(title: "Edit", message: nil, preferredStyle: .actionSheet)
                
                sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                
                sheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: {[weak self] _ in
                    
                    let alert =  UIAlertController(title: "Edit item", message: "Edit your Item", preferredStyle: .alert)
                    alert.addTextField(configurationHandler: nil)
                    alert.textFields?.first?.text = item.name
                    alert.addAction(UIAlertAction(title: "Save", style: .cancel, handler: { [weak self] _ in
                        guard let field = alert.textFields?.first,
                              let newName = field.text, !newName.isEmpty else { return }
                        self?.todoListVM.updateItem(item: item, newName: newName) {
                            DispatchQueue.main.async {
                                self?.todoListView.tableView.reloadData()
                            }
                        }
                    }))
                    self?.present(alert, animated: true)
                }))
                
                
                sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
                    self?.todoListVM.deleteItem(item: item) {
                        DispatchQueue.main.async {
                            self?.todoListView.tableView.reloadData()
                        }
                    }
                }))
                
                self.present(sheet, animated: true)
            }
            .store(in: &subscriptions)
        
        
        
    }
}

