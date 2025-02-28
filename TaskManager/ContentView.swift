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
    @State private var sortOption: SortOption = .dueDate
    @State private var lastDeletedTask: TaskItem?
    
    @State private var showUndoAlert = false
    
    private var taskCompletionPercentage: Double {
        let totalTasks = items.count
        let completedTasks = items.filter { $0.isCompleted }.count
        return totalTasks == 0 ? 0 : Double(completedTasks) / Double(totalTasks)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if items.isEmpty {
                    EmptyTaskView(taskType: .all, allEmpty: true)
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
                        
                        Menu {
                            ForEach(SortOption.allCases, id: \.self) { option in
                                Button(action: { sortOption = option }) {
                                    Text(option.rawValue)
                                }
                            }
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease")
                                .font(.title)
                                .padding(.trailing, 10)
                        }
                       
                    }
                    .padding(.leading, 20)
                    
                    
                    if filteredTasks.isEmpty {
                        Spacer()
                        EmptyTaskView(taskType: filter, allEmpty: false)
                        Spacer()
                    } else {
                        List {
                            ForEach(filteredTasks, id: \.id) { item in
                                NavigationLink(destination: TaskDetailsView(task: item)) {
                                    Text("\(item.title ?? "")")
                                }
                            }
                            .onDelete(perform: deleteItems)
                        }
                    }
                }
            }
            .navigationTitle("Tasks")
            .onChange(of: sortOption) { newValue in
                sortOption = newValue
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: { showAddTaskView.toggle() }) {
                        withAnimation(.easeOut(duration: 0.2)) {
                            Label("Add Item", systemImage: "plus.circle.fill")
                                .foregroundColor(.accentColor)
                                .scaleEffect(1.1)
                            
                        }
                    }
                }
            }
            .sheet(isPresented: $showAddTaskView) {
                AddTaskView()
            }
            .alert("Task Deleted", isPresented: $showUndoAlert) {
                Button("Undo", role: .cancel) {
                    undoDelete()
                }
                Button("Dismiss", role: .destructive) {}
            } message: {
                Text("Do you want to undo the delete?")
            }
        }
    }
    
    func undoDelete() {
        if let task = lastDeletedTask {
            viewContext.insert(task)
            lastDeletedTask = nil
            
            saveChanges()
        }
    }
    
 
    private var filteredTasks: [TaskItem] {
        
        let filteredItems: [TaskItem]
        switch filter {
        case .all: filteredItems = items.map { $0 }
        case .pending: filteredItems = items.filter { !$0.isCompleted }
        case .completed: filteredItems = items.filter { $0.isCompleted }
            
        }
        
        switch sortOption {
            
        case .priority:
            return filteredItems.sorted { $0.priorityValue > $1.priorityValue }
            
        case .dueDate:
            return filteredItems.sorted {
                guard let date1 = $0.dueDate, let date2 = $1.dueDate else {
                    return $0.dueDate != nil
                }
                return date1 < date2
            }
            
        case .alphabetically:
            return filteredItems.sorted {
                guard let title1 = $0.title?.lowercased(), let title2 = $1.title?.lowercased() else {
                    return $0.title != nil
                }
                return title1 < title2
            }
        }
    }


    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { filteredTasks[$0] }.forEach(viewContext.delete)
            //lastDeletedTask = items[$0]
            if let index = offsets.first {
                let task = filteredTasks[index] // Accessing the element
                lastDeletedTask = task
            }
            saveChanges()
            showUndoAlert = true
        }
    }
    private func saveChanges() {
        do {
            
        } catch {
            print("Failed to save: \(error.localizedDescription)")
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
