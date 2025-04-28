//
//  ListPresenter.swift
//  To Do List
//
//  Created on 28/04/2025.
//

import Foundation

class ListPresenter: ListPresenterProtocol {
    weak var view: ListViewProtocol?
    
    private let dataManager: DataManagerProtocol
    private var categories: [Category] = []
    
    init(dataManager: DataManagerProtocol) {
        self.dataManager = dataManager
    }
    
    var numberOfCategories: Int {
        return categories.count
    }
    
    func viewDidLoad() {
        loadCategories()
    }
    
    func getCategoryTitle(at index: Int) -> String {
        guard index < categories.count else { return "" }
        return categories[index].title ?? ""
    }
    
    func addNewCategory(title: String) {
        guard !title.isEmpty else {
            view?.showAlert(title: "Error", message: "Category name cannot be empty")
            return
        }
        
        _ = dataManager.saveCategory(title: title)
        loadCategories()
    }
    
    func didSelectCategory(at index: Int) -> Category {
        guard index < categories.count else {
            fatalError("Index out of range")
        }
        return categories[index]
    }
    
    // MARK: - Private Methods
    
    private func loadCategories() {
        categories = dataManager.fetchAllCategories()
        view?.reloadData()
    }
} 