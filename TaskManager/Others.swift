//
//  Others.swift
//  TaskManager
//
//  Created by mhaashim on 01/03/25.
//
import SwiftUI

enum TaskFilter: String {
    case all
    case pending
    case completed
}

enum SortOption: String, CaseIterable {
    case priority
    case dueDate
    case alphabetically
}

struct FilterButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
 
    let selectedColor: Color = Color(red: 179/255, green: 255/255, blue: 179/255)
    let filterColor: Color = Color(red: 230/255, green: 230/255, blue: 230/255)
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundStyle(Color(red: 140/255, green: 140/255, blue: 140/255))
                .bold()
                .padding(.horizontal, 12)
                .padding(.vertical, 5)
        }
        .background(isSelected ? selectedColor : filterColor)
        .cornerRadius(10)
    }
}

extension TaskItem {
    var priorityValue: Int16 {
        switch priority {
        case "Low": return 1
        case "Medium": return 2
        case "High": return 3
        default: return 0
        }
    }
}

enum AccentColor: String, CaseIterable {
    case blue, green, red, purple, orange
    
    var color: Color {
        switch self {
        case .blue: return .blue
        case .green: return .green
        case .red: return .red
        case .purple: return .purple
        case .orange: return .orange
        }
    }
}
