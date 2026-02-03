//
//  FeatureToggle.swift
//  EnvironmentSettings
//
//  Created by Alex Trubacs on 03/02/2026.
//

import Foundation

struct FeatureToggle: Identifiable, Codable, Equatable {
    let id: String
    let displayName: String
    var isEnabled: Bool
}
