//
//  ContentView.swift
//  TaskManager
//
//  Created by mhaashim on 26/02/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \TaskItem.dueDate, ascending: true)],
        animation: .default)
    private var items: FetchedResults<TaskItem>
    @State private var showAddTaskView = false
    @State private var filter: TaskFilter = .all
    
    private var taskCompletionPercentage: Double {
        let totalTasks = items.count
        let completedTasks = items.filter { $0.isCompleted }.count
        return totalTasks == 0 ? 0 : Double(completedTasks) / Double(totalTasks)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if items.isEmpty {
                    EmptyTaskView()
                } else {
                    HStack {
                        Text("Task Progress")
                            .font(.headline)
                        Spacer()
                        ProgessIndicator(progress: taskCompletionPercentage)
                    }
                    .padding()
                    
                    HStack {
                        FilterButton(title: "All", isSelected: filter == .all) {
                            filter = .all
                        }
                        
                        FilterButton(title: "Pending", isSelected: filter == .pending) {
                            filter = .pending
                        }
                        
                        FilterButton(title: "Completed", isSelected: filter == .completed) {
                            filter = .completed
                        }
                        
                        
                        Spacer()
                    }
                    .padding(.leading, 20)
                    
                   
                    
                    
                    List {
                        ForEach(filteredTasks, id: \.id) { item in
                            TaskDetailsView(task: item)
                        }
                        .onDelete(perform: deleteItems)
                    }
                }
            }
            .navigationTitle("Tasks")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: { showAddTaskView.toggle() }) {
                        Label("Add Item", systemImage: "plus.circle.fill")
                            .foregroundColor(.accentColor)
                            .scaleEffect(1.1)
                    }
                }
            }
            .sheet(isPresented: $showAddTaskView) {
                AddTaskView()
            }
        }
    }
    
    private var filteredTasks: [TaskItem] {
        switch filter {
        case .all: return items.map { $0 }
        case .pending: return items.filter { !$0.isCompleted }
        case .completed: return items.filter { $0.isCompleted }
        }
    }


    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
