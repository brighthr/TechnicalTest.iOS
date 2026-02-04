//
//  EnvironmentSettingsCard.swift
//  EnvironmentSettings
//
//  Created by Alex Trubacs on 03/02/2026.
//

import SwiftUI

struct EnvironmentSettingsCard: View {
    let environment: EnvironmentName
    let isOverrideEnabled: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 22) {
            HStack {
                Text("Environment:")
                    .foregroundStyle(.secondary)
                Spacer()
                Text(environment.description)
                    .fontWeight(.semibold)
                    .foregroundStyle(.red)
            }
            
            Divider()
            
            HStack {
                Text("Feature Override")
                    .foregroundStyle(.secondary)
                Spacer()
                Text(isOverrideEnabled ? "Enabled" : "Disabled")
                    .fontWeight(.semibold)
                    .foregroundStyle(isOverrideEnabled  ? .green : .secondary)
            }
        }
        .padding()
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .padding()
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityDescription)
    }
}

#Preview {
    EnvironmentSettingsCard(
        environment: .live,
        isOverrideEnabled: true
    )
}
private extension EnvironmentSettingsCard {
    var accessibilityDescription: String {
        let overrideStatus = isOverrideEnabled ? "enabled" : "disabled"
        return "Current environment is \(environment.description). Feature override is \(overrideStatus)."
    }
}
