//
//  MVPProtocols.swift
//  To Do List
//
//  Created on 28/04/2025.
//

import Foundation
import UIKit

// MARK: - List Screen Protocols

protocol ListViewProtocol: AnyObject {
    func reloadData()
    func showAlert(title: String, message: String)
}

protocol ListPresenterProtocol: AnyObject {
    var view: ListViewProtocol? { get set }
    var numberOfCategories: Int { get }
    
    func viewDidLoad()
    func getCategoryTitle(at index: Int) -> String
    func addNewCategory(title: String)
    func didSelectCategory(at index: Int) -> Category
}

// MARK: - Item Screen Protocols

protocol ItemViewProtocol: AnyObject {
    func reloadData()
    func showAlert(title: String, message: String)
}

protocol ItemPresenterProtocol: AnyObject {
    var view: ItemViewProtocol? { get set }
    var numberOfItems: Int { get }
    var categoryTitle: String { get }
    
    func viewDidLoad()
    func getItemTitle(at index: Int) -> String
    func isItemDone(at index: Int) -> Bool
    func addNewItem(title: String)
    func updateItem(at index: Int)
    func deleteItem(at index: Int)
}

// MARK: - Data Manager Protocol

protocol DataManagerProtocol: AnyObject {
    // Category operations
    func fetchAllCategories() -> [Category]
    func saveCategory(title: String) -> Category
    
    // Item operations
    func fetchItems(for category: Category) -> [Item]
    func saveItem(title: String, in category: Category) -> Item
    func toggleItemStatus(item: Item)
    func deleteItem(item: Item)
    func saveChanges()
} 