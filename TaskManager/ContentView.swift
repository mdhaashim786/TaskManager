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

    var body: some View {
        NavigationStack {
            VStack {
                if items.isEmpty {
                    EmptyTaskView()
                } else {
                    List {
                        ForEach(items, id: \.id) { item in
                            NavigationLink {
                                Text("Item at \(item.dueDate ?? Date(), formatter: itemFormatter)")
                            } label: {
                                Text(item.dueDate ?? Date(), formatter: itemFormatter)
                            }
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
