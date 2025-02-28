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
