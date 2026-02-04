//
//  EnvironmentSettingsViewModel.swift
//  EnvironmentSettings
//
//  Created by Alex Trubacs on 03/02/2026.
//

import SwiftUI

@Observable
final class EnvironmentSettingsViewModel {
    private(set) var state: EnvironmentSettingsState

    private let environmentStore: EnvironmentStoring
    private let featureSwitchWorker: BHRFeatureSwitchWorkerProtocol
    
    var enabledOverrides: [FeatureToggle] {
        state.featureToggles.filter({ $0.isEnabled })
    }

    convenience init() {
        self.init(
            environmentStore: EnvironmentStore.shared,
            featureSwitchWorker: BHRFeatureSwitchWorker()
        )
    }

    init(
        environmentStore: EnvironmentStoring,
        featureSwitchWorker: BHRFeatureSwitchWorkerProtocol
    ) {
        self.environmentStore = environmentStore
        self.featureSwitchWorker = featureSwitchWorker

        self.state = EnvironmentSettingsState(
            selectedOAuthEnvironment: environmentStore.activeEnvironment,
            isFeatureOverrideEnabled: featureSwitchWorker.getFeatureOverridePreference(),
            featureToggles: (featureSwitchWorker.getFeatureToggles() ?? []).map {
                FeatureToggle(id: $0.featureName, displayName: $0.featureName, isEnabled: $0.isEnabled)
            }
        )
    }

    func selectOAuthEnvironment(_ environment: EnvironmentName) {
        state.selectedOAuthEnvironment = environment
        environmentStore.activeEnvironment = environment
    }

    func toggleFeatureOverride(_ enabled: Bool) {
        withAnimation(.bouncy) {
            state.isFeatureOverrideEnabled = enabled
            featureSwitchWorker.updateFeatureOverride(isOn: enabled)
        }
    }

    func toggleFeature(_ feature: FeatureToggle) {
        guard let index = state.featureToggles.firstIndex(where: { $0.id == feature.id }) else { return }
        state.featureToggles[index].isEnabled.toggle()

        let toggles = state.featureToggles.map {
            BHRFeatureToggle(featureName: $0.id, isEnabled: $0.isEnabled)
        }
        featureSwitchWorker.setFeatureToggles(toggles)
    }
}
