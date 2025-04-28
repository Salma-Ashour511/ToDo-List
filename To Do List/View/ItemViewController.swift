//
//  ItemViewController.swift
//  To Do List
//
//  Created by V17SAshour1 on 26/04/2025.
//

import UIKit

class ItemViewController: UIViewController {
   
    @IBOutlet weak var itemsTableView: UITableView!

    private var presenter: ItemPresenterProtocol!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        if presenter != nil {
            presenter.viewDidLoad()
        }
    }
    
    // MARK: - Setup
    
    func configure(with category: Category) {
        presenter = DependencyContainer.shared.makeItemPresenter(category: category)
        presenter.view = self
        title = presenter.categoryTitle
        
        // If view is already loaded, trigger presenter viewDidLoad
        if isViewLoaded {
            presenter.viewDidLoad()
        }
    }
    
    private func setupTableView() {
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
    }

    // MARK: - Actions
    
    @IBAction func newItemButtonClicked(_ sender: UIButton) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new Item", message: "Type your Item name here..", preferredStyle: .alert)
        let action = UIAlertAction(title: "Done", style: .default) { [weak self] action in
            guard let self = self else { return }
            
            if let newItemName = textField.text, !newItemName.isEmpty {
                self.presenter.addNewItem(title: newItemName)
            }
        }
        
        alert.addAction(action)
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Title"
            textField = alertTextField
        }
        
        present(alert, animated: true)
    }
}

// MARK: - ItemViewProtocol

extension ItemViewController: ItemViewProtocol {
    func reloadData() {
        itemsTableView.reloadData()
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ItemViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "MY ITEMS"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell") else { 
            return UITableViewCell() 
        }
        
        var content = cell.defaultContentConfiguration()
        content.text = presenter.getItemTitle(at: indexPath.row)
        
        let isDone = presenter.isItemDone(at: indexPath.row)
        content.image = isDone ?
            UIImage(systemName: "checkmark.circle.fill") :
            UIImage(systemName: "circle")
        
        content.imageProperties.tintColor = UIColor(red: 0.99, green: 0.79, blue: 0.43, alpha: 1.0)
        cell.contentConfiguration = content
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.updateItem(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.deleteItem(at: indexPath.row)
        }
    }
}


