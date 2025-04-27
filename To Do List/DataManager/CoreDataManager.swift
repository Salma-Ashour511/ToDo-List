//
//  CoreDataManager.swift
//  To Do List
//
//  Created by V17SAshour1 on 26/04/2025.
//

import UIKit
import CoreData

class CoreDataManager {
    var items = [Item]()
    var categories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    // save
    func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
    
    // fetch
    func fetchCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
            categories = try context.fetch(request)
        } catch {
            print("Error saving context: \(error)")
        }
    }
    
    func fetchItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), categoryTitle: String) {
        let categoryPredicate = NSPredicate(format: "parentCategory.title MATCHES %@", categoryTitle)
        request.predicate = categoryPredicate
        
        do {
            items = try context.fetch(request)
        } catch {
            print("Error saving context: \(error)")
        }
    }
    
    // update
    func updateItem(at index: Int) {
        items[index].done = !items[index].done
        saveContext()
    }
    
    
    //delete
    func delete(at index: Int) {
        context.delete(items[index])
        items.remove(at: index)
        saveContext()
    }
}
