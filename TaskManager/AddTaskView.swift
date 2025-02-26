//
//  AddTaskView.swift
//  TaskManager
//
//  Created by mhaashim on 26/02/25.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    @State private var title: String = ""
    @State private var description: String = ""
    @State private var dueDate: Date = Date()
    @State private var priority: String = "Medium"

    let priorities = ["Low", "Medium", "High"]

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Task Info")) {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description)
                }
                Section(header: Text("Details")) {
                    Picker("Priority", selection: $priority) {
                        ForEach(priorities, id: \.self) { Text($0) }
                    }
                    DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                }
            }
            .navigationTitle("New Task")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { saveTask() }
                }
            }
        }
    }

    private func saveTask() {
        withAnimation {
            let newTask = TaskItem(context: viewContext)
            newTask.id = UUID()
            newTask.title = title
            newTask.titleDescription = description
            newTask.priority = priority
            newTask.dueDate = dueDate
            newTask.isCompleted = false
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            dismiss()
        }
    }
    
}
