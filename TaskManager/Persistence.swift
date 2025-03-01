//
//  Persistence.swift
//  TaskManager
//
//  Created by mhaashim on 26/02/25.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    @MainActor
    static let preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        let task1 = TaskItem(context: viewContext)
        task1.id = UUID()
        task1.title = "Buy groceries"
        task1.titleDescription = "Milk, eggs, bread"
        task1.priority = "High"
        task1.dueDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        task1.isCompleted = false
        
        let task2 = TaskItem(context: viewContext)
        task2.id = UUID()
        task2.title = "Complete SwiftUI project"
        task2.titleDescription = "Finish the animations and polish UI"
        task2.priority = "Medium"
        task2.dueDate = Calendar.current.date(byAdding: .day, value: 3, to: Date())
        task2.isCompleted = false
        
        let task3 = TaskItem(context: viewContext)
        task3.id = UUID()
        task3.title = "Workout"
        task3.titleDescription = "Morning exercise routine"
        task3.priority = "Low"
        task3.dueDate = Calendar.current.date(byAdding: .day, value: 0, to: Date())
        task3.isCompleted = false
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "TaskManager")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
