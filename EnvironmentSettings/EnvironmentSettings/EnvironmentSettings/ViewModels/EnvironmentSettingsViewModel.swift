//
//  EnvironmentSettingsViewModel.swift
//  EnvironmentSettings
//
//  Created by Alex Trubacs on 03/02/2026.
//

import SwiftUI

@Observable
final class EnvironmentSettingsViewModel {
    var state: EnvironmentSettingsState
    
    private let environmentStore: EnvironmentStore
    private let featureSwitchWorker: BHRFeatureSwitchWorker
    
    init(state: EnvironmentSettingsState,
         environmentStore: EnvironmentStore,
         featureSwitchWorker: BHRFeatureSwitchWorker
    ) {
        self.state = state
        self.environmentStore = environmentStore
        self.featureSwitchWorker = featureSwitchWorker
    }
    
    func selectOAuthEnvironment(_ environment: EnvironmentName) {
        
    }
    
    func toggleFeatureOverride(_ enabled: Bool) {
        
    }
    
    func toggleFeature(_ feature: FeatureToggle) {
        
    }
}
