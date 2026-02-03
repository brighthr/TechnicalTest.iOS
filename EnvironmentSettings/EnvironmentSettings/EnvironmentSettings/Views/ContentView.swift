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
        NavigationStack {
            VStack {
                environmentStatusView
                NavigationLink("Configure Settings") {
                    EnvironmentSettingsView(viewModel: viewModel)
                }
                .buttonStyle(.glassProminent)
            }
            .navigationTitle("Environment")
        }
    }
}

#Preview {
    ContentView()
}

private extension ContentView {
    var environmentStatusView: some View {
        EnvironmentSettingsCard(
            environment: viewModel.state.selectedOAuthEnvironment,
            isOverrideEnabled: viewModel.state.isFeatureOverrideEnabled
        )
    }
}
