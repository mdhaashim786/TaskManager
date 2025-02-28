//
//  TaskManagerApp.swift
//  TaskManager
//
//  Created by mhaashim on 26/02/25.
//

import SwiftUI

@main
struct TaskManagerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .dynamicTypeSize(.medium)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
