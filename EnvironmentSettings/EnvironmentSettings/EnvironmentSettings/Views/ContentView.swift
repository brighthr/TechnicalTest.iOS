//
//  ContentView.swift
//  EnvironmentSettings
//
//  Created by Alex Trubacs on 03/02/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel: EnvironmentSettingsViewModel = EnvironmentSettingsViewModel()
    @State private var showSettings: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                environmentStatusView
                switchedOnFeatures
                Spacer()
                settingsButton
            }
            .sheet(isPresented: $showSettings, content: {
                EnvironmentSettingsView(viewModel: viewModel)
                    .presentationBackground(.thinMaterial)
            })
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
    
    var settingsButton: some View {
        Button("Configure Settings") {
            showSettings.toggle()
        }
        .buttonStyle(.glassProminent)
        .accessibilityHint("Opens settings to change environment and feature toggles")
    }
    
    @ViewBuilder
    var switchedOnFeatures: some View {
        if !viewModel.enabledOverrides.isEmpty {
            VStack(alignment: .leading, spacing: 12) {
                Text("Overrides Enabled:")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 6)
                
                ForEach(viewModel.enabledOverrides) { feature in
                    Text(feature.displayName.capitalized)
                }
            }
            .padding()
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .padding()
            .accessibilityElement(children: .combine)
            .accessibilityLabel(enabledOverridesAccessibilityLabel)
        }
    }
    
    var enabledOverridesAccessibilityLabel: String {
        let features = viewModel.enabledOverrides.map { $0.displayName.capitalized }
        let featureList = features.joined(separator: ", ")
        return "\(features.count) overrides enabled: \(featureList)"
    }
}
