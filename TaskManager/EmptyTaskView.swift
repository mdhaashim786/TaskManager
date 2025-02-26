//
//  EmptyTaskView.swift
//  TaskManager
//
//  Created by mhaashim on 26/02/25.
//

import SwiftUI

struct EmptyTaskView: View {
    var body: some View {
        VStack {
            Image(systemName: "tray.fill")
                .font(.largeTitle)
                .foregroundColor(.gray)
            Text("No tasks yet!")
                .font(.title2)
                .foregroundColor(.gray)
                .padding()
        }
    }
}
