//
//  ItemViewController.swift
//  To Do List
//
//  Created by V17SAshour1 on 26/04/2025.
//

import UIKit

class ItemViewController: UIViewController {
    var itemsArray: [String] = []
    @IBOutlet weak var itemsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
        itemsTableView.register(UINib(nibName: "ItemTableViewCell", bundle: .main), forCellReuseIdentifier: "itemCell")
    }

    @IBAction func newItemButtonClicked(_ sender: UIButton) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new Item", message: "Type your Item name here..", preferredStyle: .alert)
        let action = UIAlertAction(title: "Done", style: .default) { action  in
            if let newList = textField.text, !newList.isEmpty {
                self.itemsArray.append(newList)
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
        itemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell") as? ItemTableViewCell else { return UITableViewCell() }        
        return cell
    }
}

