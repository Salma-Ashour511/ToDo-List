//
//  ItemPresenter.swift
//  To Do List
//
//  Created on 28/04/2025.
//

import Foundation

class ItemPresenter: ItemPresenterProtocol {
    weak var view: ItemViewProtocol?
    
    private let dataManager: DataManagerProtocol
    private var items: [Item] = []
    private var category: Category
    
    var numberOfItems: Int {
        return items.count
    }
    
    var categoryTitle: String {
        return category.title ?? ""
    }
    
    init(dataManager: DataManagerProtocol, category: Category) {
        self.dataManager = dataManager
        self.category = category
    }
    
    func viewDidLoad() {
        loadItems()
    }
    
    func getItemTitle(at index: Int) -> String {
        guard index < items.count else { return "" }
        return items[index].title ?? ""
    }
    
    func isItemDone(at index: Int) -> Bool {
        guard index < items.count else { return false }
        return items[index].done
    }
    
    func addNewItem(title: String) {
        guard !title.isEmpty else {
            view?.showAlert(title: "Error", message: "Item name cannot be empty")
            return
        }
        
        _ = dataManager.saveItem(title: title, in: category)
        loadItems()
    }
    
    func updateItem(at index: Int) {
        guard index < items.count else { return }
        dataManager.toggleItemStatus(item: items[index])
        loadItems()
    }
    
    func deleteItem(at index: Int) {
        guard index < items.count else { return }
        dataManager.deleteItem(item: items[index])
        loadItems()
    }
    
    // MARK: - Private Methods
    
    private func loadItems() {
        items = dataManager.fetchItems(for: category)
        view?.reloadData()
    }
} 