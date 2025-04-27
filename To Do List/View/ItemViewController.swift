//
//  ItemViewController.swift
//  To Do List
//
//  Created by V17SAshour1 on 26/04/2025.
//

import UIKit

class ItemViewController: UIViewController {
   
    @IBOutlet weak var itemsTableView: UITableView!

    var dataManager = CoreDataManager()
    var selectedCategory: Category? {
        didSet{
            dataManager.fetchItems(categoryTitle: selectedCategory?.title ?? "")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
    }

    @IBAction func newItemButtonClicked(_ sender: UIButton) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new Item", message: "Type your Item name here..", preferredStyle: .alert)
        let action = UIAlertAction(title: "Done", style: .default) { action  in
            if let newItem = textField.text, !newItem.isEmpty {
                let item = Item(context: self.dataManager.context)
                item.title = newItem
                item.done = false
                item.parentCategory = self.selectedCategory
                
                self.dataManager.items.append(item)
                self.dataManager.saveContext()
                
                self.itemsTableView.reloadData()
            }
        }
        alert.addAction(action)
        alert.addTextField { alertTextField in
            textField.placeholder = "Title"
            textField = alertTextField
        }
        
        present(alert, animated: true)
    }
}

extension ItemViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "MY ITEMS"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataManager.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell") else { return UITableViewCell() }
        var content = cell.defaultContentConfiguration()

        content.text = dataManager.items[indexPath.row].title
        content.image = dataManager.items[indexPath.row].done ?
        UIImage(systemName: "checkmark.circle.fill") :
        UIImage(systemName: "circle")
        
        content.imageProperties.tintColor = UIColor(red: 0.99, green: 0.79, blue: 0.43, alpha: 1.0)
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataManager.updateItem(at: indexPath.row)
        
        tableView.reloadData()
    }
    
    private func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dataManager.delete(at: indexPath.row)
            
            tableView.reloadData()
        }
    }
}


