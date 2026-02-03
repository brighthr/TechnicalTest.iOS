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
    }
}

#Preview {
    EnvironmentSettingsCard(
        environment: .live,
        isOverrideEnabled: true
    )
}
