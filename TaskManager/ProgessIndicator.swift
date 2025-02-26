//
//  ProgessIndicator.swift
//  TaskManager
//
//  Created by mhaashim on 26/02/25.
//

import SwiftUI

struct ProgessIndicator: View {
    var progress: Double

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 10)
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut(duration: 1.0), value: progress)
        }
        .frame(width: 50, height: 50)
    }
}
