//
//  EnvironmentSettingsState.swift
//  EnvironmentSettings
//
//  Created by Alex Trubacs on 03/02/2026.
//

import Foundation

struct EnvironmentSettingsState {
    var selectedOAuthEnvironment: EnvironmentName
    var isFeatureOverrideEnabled: Bool
    var featureToggles: [FeatureToggle]
}
