//
//  ViewController.swift
//  To Do List
//
//  Created by V17SAshour1 on 24/04/2025.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var tasksTableView: UITableView!
    
    private var presenter: ListPresenterProtocol!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPresenter()
        setupTableView()
        presenter.viewDidLoad()
    }
    
    // MARK: - Setup
    
    private func setupPresenter() {
        presenter = DependencyContainer.shared.makeListPresenter()
        presenter.view = self
    }
    
    private func setupTableView() {
        tasksTableView.delegate = self
        tasksTableView.dataSource = self
    }

    // MARK: - Actions
    
    @IBAction func newListButtonClicked(_ sender: UIButton) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new List", message: "Type your list name here..", preferredStyle: .alert)
        let action = UIAlertAction(title: "Done", style: .default) { [weak self] action in
            guard let self = self else { return }
            
            if let newListName = textField.text, !newListName.isEmpty {
                self.presenter.addNewCategory(title: newListName)
            }
        }
        
        alert.addAction(action)
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "ex: Home"
            textField = alertTextField
        }
        
        present(alert, animated: true)
    }
}

// MARK: - ListViewProtocol

extension ListViewController: ListViewProtocol {
    func reloadData() {
        tasksTableView.reloadData()
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "MY LISTS"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfCategories
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "listCell") else { 
            return UITableViewCell() 
        }
        
        var content = cell.defaultContentConfiguration()
        content.text = presenter.getCategoryTitle(at: indexPath.row)
        content.image = UIImage(systemName: "list.bullet")
        content.imageProperties.tintColor = UIColor.random
        
        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "ItemViewController") as? ItemViewController {
            if let navigator = navigationController {
                let selectedCategory = presenter.didSelectCategory(at: indexPath.row)
                viewController.configure(with: selectedCategory)
                navigator.pushViewController(viewController, animated: true)
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

