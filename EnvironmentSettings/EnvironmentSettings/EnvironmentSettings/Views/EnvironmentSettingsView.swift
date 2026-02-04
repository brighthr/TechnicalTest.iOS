//
//  EnvironmentSettingsView.swift
//  EnvironmentSettings
//
//  Created by Alex Trubacs on 03/02/2026.
//

import SwiftUI

struct EnvironmentSettingsView: View {
    @Bindable var viewModel: EnvironmentSettingsViewModel
    var body: some View {
        NavigationStack {
            Form {
                Section("OAuth Environment") {
                    ForEach(EnvironmentName.allCases, id: \.self) { environment in
                        let isSelected = viewModel.state.selectedOAuthEnvironment == environment
                        Button {
                            viewModel.selectOAuthEnvironment(environment)
                        } label: {
                            HStack {
                                Text(environment.description)
                                Spacer()
                                if isSelected {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(.blue)
                                }
                            }
                        }
                        .foregroundStyle(.primary)
                        .accessibilityValue(isSelected ? "Selected" : "Not selected")
                        .accessibilityHint(isSelected ? "Currently active" : "Double tap to select this environment")
                    }
                }
                
                Section {
                    Toggle("Enable Feature Override",
                           isOn: Binding(
                            get: { viewModel.state.isFeatureOverrideEnabled },
                            set: { viewModel.toggleFeatureOverride($0) }
                           ))
                    .accessibilityHint("Allows manual control of feature flags for testing purposes")
                } header: {
                    Text("Feature Override")
                } footer: {
                    Text("When enabled, you can manually control feature flags.")
                }
                
                if viewModel.state.isFeatureOverrideEnabled {
                    Section("Feature Toggles") {
                        ForEach(viewModel.state.featureToggles) { toggle in
                            Toggle(toggle.displayName, isOn: Binding(
                                get: { toggle.isEnabled },
                                set: { _ in viewModel.toggleFeature(toggle) }
                            ))
                            .accessibilityHint("Double tap to toggle \(toggle.displayName) feature")
                        }
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    EnvironmentSettingsView(
        viewModel: .init()
    )
}
