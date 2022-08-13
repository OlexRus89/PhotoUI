//
//  PersistenceController.swift
//  NewNCFU
//
//  Created by Алексей Свидницкий on 26.04.2022.
//

import Foundation
import CoreData


// Подключение БД
// -------------------------------------------------------------
struct PersistenceController {
    static let shared = PersistenceController()
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext

        return result
    }()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "NewNCFU")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error) ,\(error.userInfo)")
            }
            
        })
    }
}
// -------------------------------------------------------------
