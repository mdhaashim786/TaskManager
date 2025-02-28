//
//  EmptyTaskView.swift
//  TaskManager
//
//  Created by mhaashim on 26/02/25.
//

import SwiftUI

struct EmptyTaskView: View {
    
    let taskType: TaskFilter
    let allEmpty: Bool
    
    var body: some View {
        if allEmpty {
            VStack {
                Image(systemName: "tray.fill")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
                Text("No tasks yet!")
                    .font(.title2)
                    .foregroundColor(.gray)
                    .padding()
            }
        } else {
            VStack {
                Image(systemName: "tray.fill")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
                Text("No \(taskType.rawValue) tasks!")
                    .font(.title2)
                    .foregroundColor(.gray)
                    .padding()
            }
        }
    }
}
