//
//  ViewController.swift
//  Core Data
//
//  Created by Lasha Khizanishvili on 20.03.24.
//

import UIKit

class TodoListViewController: UIViewController {
    
    // MARK: - Properties
    
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
            self.todoListView.tableView.reloadData()
        }
    }
    
    // MARK: - Functions
    
    @objc private func didTappedAdd() {
        let alert =  UIAlertController(title: "New Items", message: "Enter New Item", preferredStyle: .alert)
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { [weak self] _ in
            guard let field = alert.textFields?.first,
                  let text = field.text, !text.isEmpty else { return }
            self?.todoListVM.createItem(name: text)
        }))
        present(alert, animated: true)
    }

    
}

