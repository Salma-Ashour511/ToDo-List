//
//  ViewController.swift
//  To Do List
//
//  Created by V17SAshour1 on 24/04/2025.
//

import UIKit

class ListViewController: UIViewController {

    var listArray: [String] = []
    @IBOutlet weak var tasksTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tasksTableView.delegate = self
        tasksTableView.dataSource = self
    }

    @IBAction func newListButtonClicked(_ sender: UIButton) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new List", message: "Type your list name here..", preferredStyle: .alert)
        let action = UIAlertAction(title: "Done", style: .default) { action  in
            if let newList = textField.text, !newList.isEmpty {
                self.listArray.append(newList)
                self.tasksTableView.reloadData()
            }
        }
        alert.addAction(action)
        alert.addTextField { alertTextField in
            textField.placeholder = "ex: Home"
            textField = alertTextField
        }
        
        present(alert, animated: true)
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "MY LISTS"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "listCell") else { return UITableViewCell() }
        var content = cell.defaultContentConfiguration()

        content.text = listArray[indexPath.row]
        content.image = UIImage(systemName: "list.bullet")
        content.imageProperties.tintColor = UIColor.random
        
        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "ItemViewController") as? ItemViewController {
                if let navigator = navigationController {
                    viewController.title = listArray[indexPath.row]
                    navigator.pushViewController(viewController, animated: true)
                }
            }
    }
}

