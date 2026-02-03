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
            }
        }
    }
}

#Preview {
    ContentView()
}

private extension ContentView {
    var environmentStatusView: some View {
        VStack(alignment: .leading, spacing: 22) {
            HStack {
                Text("Environment:")
                    .foregroundStyle(.secondary)
                Spacer()
                Text(viewModel.state.selectedOAuthEnvironment.description)
                    .fontWeight(.semibold)
                    .foregroundStyle(.red)
            }
            
            Divider()
            
            HStack {
                Text("Feature Override")
                    .foregroundStyle(.secondary)
                Spacer()
                Text(viewModel.state.isFeatureOverrideEnabled ? "Enabled" : "Disabled")
                    .fontWeight(.semibold)
                    .foregroundStyle(viewModel.state.isFeatureOverrideEnabled  ? .green : .secondary)
            }
        }
        .padding()
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .padding()
    }
}
