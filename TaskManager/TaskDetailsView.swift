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
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 15) {
                Text(task.title ?? "")
                    .font(.title)
                    .fontWeight(.bold)
                    .strikethrough(task.isCompleted, color: .gray)
                    .padding(.bottom, 5)
                
                Text(task.titleDescription ?? "")
                    .font(.body)
                    .foregroundColor(.secondary)
                
                Text(task.dueDate ?? Date(), style: .date)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Divider()
                
                if task.isCompleted {
                    HStack {
                        Spacer()
                        VStack(spacing: 10) {
                            Image(systemName: "checkmark.seal.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.accentColor )
                            
                            Text("Task Completed!")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.accentColor)
                        }
                        .padding(.top, 10)
                        Spacer()
                    }
                } else {
                    VStack(spacing: 10) {
                        Button(action: toggleCompletion) {
                            Text("Mark as Complete")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        
                        
                    }
                    .padding(.top, 10)
                }
                Button(action: deleteTask) {
                    Text("Delete Task")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 10)
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(radius: 5)
            .padding()
            
            Spacer()
        }
        .navigationTitle("Task Details")
    }
    
    
    private func toggleCompletion() {
        let impactFeedback = UIImpactFeedbackGenerator(style: .heavy)
        impactFeedback.impactOccurred()
        task.isCompleted = true
        saveChanges()
        dismiss()
    }
    private func deleteTask() {
        viewContext.delete(task)
        saveChanges()
        dismiss()
    }
    

    
    
    
    private func saveChanges() {
        do {
            try viewContext.save()
        } catch {
            print("Failed to save: \(error.localizedDescription)")
        }
    }
}
