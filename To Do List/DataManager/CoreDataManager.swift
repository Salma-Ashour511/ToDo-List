//
//  CoreDataManager.swift
//  To Do List
//
//  Created by V17SAshour1 on 26/04/2025.
//

import UIKit
import CoreData

class CoreDataManager: DataManagerProtocol {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - Save Context
    
    func saveChanges() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
    
    // MARK: - Category Operations
    
    func fetchAllCategories() -> [Category] {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            return try context.fetch(request)
        } catch {
            print("Error fetching categories: \(error)")
            return []
        }
    }
    
    func saveCategory(title: String) -> Category {
        let newCategory = Category(context: context)
        newCategory.title = title
        saveChanges()
        return newCategory
    }
    
    // MARK: - Item Operations
    
    func fetchItems(for category: Category) -> [Item] {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        let predicate = NSPredicate(format: "parentCategory.title MATCHES %@", category.title ?? "")
        request.predicate = predicate
        
        do {
            return try context.fetch(request)
        } catch {
            print("Error fetching items: \(error)")
            return []
        }
    }
    
    func saveItem(title: String, in category: Category) -> Item {
        let newItem = Item(context: context)
        newItem.title = title
        newItem.done = false
        newItem.parentCategory = category
        saveChanges()
        return newItem
    }
    
    func toggleItemStatus(item: Item) {
        item.done = !item.done
        saveChanges()
    }
    
    func deleteItem(item: Item) {
        context.delete(item)
        saveChanges()
    }
}
