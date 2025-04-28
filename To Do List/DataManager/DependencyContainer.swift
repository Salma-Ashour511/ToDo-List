//
//  DependencyContainer.swift
//  To Do List
//
//  Created on 28/04/2025.
//

import Foundation

/// A container that manages all dependencies for the application
class DependencyContainer {
    // MARK: - Singleton
    
    static let shared = DependencyContainer()
    
    private init() {}
    
    // MARK: - Dependencies
    
    /// Provides the data manager implementation
    lazy var dataManager: DataManagerProtocol = {
        return CoreDataManager()
    }()
    
    // MARK: - Factory Methods
    
    /// Creates a list presenter
    func makeListPresenter() -> ListPresenterProtocol {
        return ListPresenter(dataManager: dataManager)
    }
    
    /// Creates an item presenter for a specific category
    func makeItemPresenter(category: Category) -> ItemPresenterProtocol {
        return ItemPresenter(dataManager: dataManager, category: category)
    }
} 
