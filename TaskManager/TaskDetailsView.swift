//
//  TaskDetailsView.swift
//  TaskManager
//
//  Created by mhaashim on 26/02/25.
//

import SwiftUI

struct TaskDetailsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var task: TaskItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(task.title ?? "")
                    .font(.headline)
                    .strikethrough(task.isCompleted, color: .gray)
                Text(task.titleDescription ?? "")
                    .font(.subheadline)
                Text(task.dueDate ?? Date(), style: .date)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            if task.isCompleted {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
            }
        }
        .swipeActions {
            Button {
                toggleCompletion()
            } label: {
                Label("Complete", systemImage: "checkmark")
            }
            .tint(.green)
            
            Button(role: .destructive) {
                deleteTask()
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
    }
    
    private func toggleCompletion() {
        task.isCompleted.toggle()
        saveChanges()
    }
    private func deleteTask() {
        viewContext.delete(task)
        saveChanges()
    }
    
    private func saveChanges() {
        do {
            try viewContext.save()
        } catch {
            print("Failed to save: \(error.localizedDescription)")
        }
    }
}
