//
//  ContentView.swift
//  EnvironmentSettings
//
//  Created by Alex Trubacs on 03/02/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel: EnvironmentSettingsViewModel = EnvironmentSettingsViewModel()
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    ContentView()
}
