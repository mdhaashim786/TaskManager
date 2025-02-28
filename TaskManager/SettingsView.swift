//
//  SettingsView.swift
//  TaskManager
//
//  Created by mhaashim on 01/03/25.
//

import SwiftUI

class AccentColorManager: ObservableObject {
    @AppStorage("selectedAccentColor") var storedColor: String = AccentColor.blue.rawValue
    
    var currentColor: Color {
        AccentColor(rawValue: storedColor)?.color ?? .blue
    }
    
    func updateColor(_ newColor: AccentColor) {
        storedColor = newColor.rawValue
        objectWillChange.send()
    }
}


public struct SettingsView: View {
    @ObservedObject var colorManager: AccentColorManager
    
    private var colorBinding: Binding<AccentColor> {
            Binding(
                get: { AccentColor(rawValue: colorManager.storedColor) ?? .blue },
                set: { colorManager.updateColor($0) }
            )
        }
    
    public var body: some View {
        Form {
            Section(header: Text("Select Accent Color")) {
                Picker("Accent Color", selection: colorBinding) {
                    ForEach(AccentColor.allCases, id: \.self) { color in
                        HStack {
                            Circle()
                                .fill(color.color)
                                .frame(width: 20, height: 20)
                            Text(color.rawValue.capitalized)
                        }
                    }
                }
                .pickerStyle(.inline)
            }
        }
        .navigationTitle("Settings")
    }
}
