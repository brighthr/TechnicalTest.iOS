//
//  EnvironmentSettingsTests.swift
//  EnvironmentSettingsTests
//
//  Created by Tony Phan on 06/01/2026.
//

import XCTest
@testable import EnvironmentSettings

// MARK: - Mock Classes
final class MockEnvironmentStore: EnvironmentStoring {
    var activeEnvironment: EnvironmentName = .uat
    
    // Track if setter was called (for verifying persistence)
    var didSetEnvironment: Bool = false
    var setEnvironmentCallCount: Int = 0
}

final class MockFeatureSwitchWorker: BHRFeatureSwitchWorkerProtocol {
    // Stored state
    var storedToggles: [BHRFeatureToggle] = []
    var featureOverrideEnabled: Bool = false
    
    // Call tracking for verification
    var setFeatureTogglesCallCount: Int = 0
    var updateFeatureOverrideCallCount: Int = 0
    var lastSetOverrideValue: Bool?
    
    func setFeatureToggles(_ featureToggles: [BHRFeatureToggle]) {
        storedToggles = featureToggles
        setFeatureTogglesCallCount += 1
    }
    
    func getFeatureToggles() -> [BHRFeatureToggle]? {
        return storedToggles.isEmpty ? nil : storedToggles
    }
    
    func getFeatureOverridePreference() -> Bool {
        return featureOverrideEnabled
    }
    
    func setFeatureTogglesFromJson(_ json: [String: Bool]) {
        storedToggles = json.compactMap { BHRFeatureToggle(featureName: $0.key, isEnabled: $0.value) }
    }
    
    func updateFeatureOverride(isOn: Bool) {
        featureOverrideEnabled = isOn
        lastSetOverrideValue = isOn
        updateFeatureOverrideCallCount += 1
    }
    
    func isEnabledFeature(_ featureName: String) -> Bool {
        return storedToggles.first { $0.featureName == featureName }?.isEnabled ?? false
    }
}

// MARK: - ViewModel Tests

final class EnvironmentSettingsViewModelTests: XCTestCase {
    
    // System Under Test
    private var sut: EnvironmentSettingsViewModel!
    
    // Mocks
    private var mockEnvironmentStore: MockEnvironmentStore!
    private var mockFeatureSwitchWorker: MockFeatureSwitchWorker!
    
    override func setUp() {
        super.setUp()
        mockEnvironmentStore = MockEnvironmentStore()
        mockFeatureSwitchWorker = MockFeatureSwitchWorker()
    }
    
    override func tearDown() {
        sut = nil
        mockEnvironmentStore = nil
        mockFeatureSwitchWorker = nil
        super.tearDown()
    }
    
    // MARK: - Initialization Tests
    
    func test_init_loadsEnvironmentFromStore() {
        // Given
        mockEnvironmentStore.activeEnvironment = .live
        
        // When
        sut = EnvironmentSettingsViewModel(
            environmentStore: mockEnvironmentStore,
            featureSwitchWorker: mockFeatureSwitchWorker
        )
        
        // Then
        XCTAssertEqual(sut.state.selectedOAuthEnvironment, .live)
    }
    
    func test_init_loadsFeatureOverridePreference() {
        // Given
        mockFeatureSwitchWorker.featureOverrideEnabled = true
        
        // When
        sut = EnvironmentSettingsViewModel(
            environmentStore: mockEnvironmentStore,
            featureSwitchWorker: mockFeatureSwitchWorker
        )
        
        // Then
        XCTAssertTrue(sut.state.isFeatureOverrideEnabled)
    }
    
    func test_init_loadsFeatureToggles() {
        // Given
        mockFeatureSwitchWorker.storedToggles = [
            BHRFeatureToggle(featureName: "dark_mode", isEnabled: true),
            BHRFeatureToggle(featureName: "new_ui", isEnabled: false)
        ]
        
        // When
        sut = EnvironmentSettingsViewModel(
            environmentStore: mockEnvironmentStore,
            featureSwitchWorker: mockFeatureSwitchWorker
        )
        
        // Then
        XCTAssertEqual(sut.state.featureToggles.count, 2)
        XCTAssertEqual(sut.state.featureToggles[0].id, "dark_mode")
        XCTAssertTrue(sut.state.featureToggles[0].isEnabled)
        XCTAssertEqual(sut.state.featureToggles[1].id, "new_ui")
        XCTAssertFalse(sut.state.featureToggles[1].isEnabled)
    }
    
    // MARK: - selectOAuthEnvironment Tests
    
    func test_selectOAuthEnvironment_updatesState() {
        // Given
        mockEnvironmentStore.activeEnvironment = .uat
        sut = EnvironmentSettingsViewModel(
            environmentStore: mockEnvironmentStore,
            featureSwitchWorker: mockFeatureSwitchWorker
        )
        XCTAssertEqual(sut.state.selectedOAuthEnvironment, .uat)
        
        // When
        sut.selectOAuthEnvironment(.live)
        
        // Then
        XCTAssertEqual(sut.state.selectedOAuthEnvironment, .live)
    }
    
    func test_selectOAuthEnvironment_persistsToStore() {
        // Given
        sut = EnvironmentSettingsViewModel(
            environmentStore: mockEnvironmentStore,
            featureSwitchWorker: mockFeatureSwitchWorker
        )
        
        // When
        sut.selectOAuthEnvironment(.qa01)
        
        // Then
        XCTAssertEqual(mockEnvironmentStore.activeEnvironment, .qa01)
    }
    
    func test_selectOAuthEnvironment_canSelectAllEnvironments() {
        // Given
        sut = EnvironmentSettingsViewModel(
            environmentStore: mockEnvironmentStore,
            featureSwitchWorker: mockFeatureSwitchWorker
        )
        
        // When/Then - verify all environments can be selected
        for environment in EnvironmentName.allCases {
            sut.selectOAuthEnvironment(environment)
            XCTAssertEqual(sut.state.selectedOAuthEnvironment, environment)
            XCTAssertEqual(mockEnvironmentStore.activeEnvironment, environment)
        }
    }
    
    // MARK: - toggleFeatureOverride Tests
    
    func test_toggleFeatureOverride_enable_updatesState() {
        // Given
        mockFeatureSwitchWorker.featureOverrideEnabled = false
        sut = EnvironmentSettingsViewModel(
            environmentStore: mockEnvironmentStore,
            featureSwitchWorker: mockFeatureSwitchWorker
        )
        XCTAssertFalse(sut.state.isFeatureOverrideEnabled)
        
        // When
        sut.toggleFeatureOverride(true)
        
        // Then
        XCTAssertTrue(sut.state.isFeatureOverrideEnabled)
    }
    
    func test_toggleFeatureOverride_disable_updatesState() {
        // Given
        mockFeatureSwitchWorker.featureOverrideEnabled = true
        sut = EnvironmentSettingsViewModel(
            environmentStore: mockEnvironmentStore,
            featureSwitchWorker: mockFeatureSwitchWorker
        )
        XCTAssertTrue(sut.state.isFeatureOverrideEnabled)
        
        // When
        sut.toggleFeatureOverride(false)
        
        // Then
        XCTAssertFalse(sut.state.isFeatureOverrideEnabled)
    }
    
    func test_toggleFeatureOverride_persistsToWorker() {
        // Given
        sut = EnvironmentSettingsViewModel(
            environmentStore: mockEnvironmentStore,
            featureSwitchWorker: mockFeatureSwitchWorker
        )
        
        // When
        sut.toggleFeatureOverride(true)
        
        // Then
        XCTAssertEqual(mockFeatureSwitchWorker.updateFeatureOverrideCallCount, 1)
        XCTAssertEqual(mockFeatureSwitchWorker.lastSetOverrideValue, true)
    }
    
    // MARK: - toggleFeature Tests
    
    func test_toggleFeature_enablesDisabledFeature() {
        // Given
        mockFeatureSwitchWorker.storedToggles = [
            BHRFeatureToggle(featureName: "feature_a", isEnabled: false)
        ]
        sut = EnvironmentSettingsViewModel(
            environmentStore: mockEnvironmentStore,
            featureSwitchWorker: mockFeatureSwitchWorker
        )
        let featureToToggle = sut.state.featureToggles[0]
        XCTAssertFalse(featureToToggle.isEnabled)
        
        // When
        sut.toggleFeature(featureToToggle)
        
        // Then
        XCTAssertTrue(sut.state.featureToggles[0].isEnabled)
    }
    
    func test_toggleFeature_disablesEnabledFeature() {
        // Given
        mockFeatureSwitchWorker.storedToggles = [
            BHRFeatureToggle(featureName: "feature_a", isEnabled: true)
        ]
        sut = EnvironmentSettingsViewModel(
            environmentStore: mockEnvironmentStore,
            featureSwitchWorker: mockFeatureSwitchWorker
        )
        let featureToToggle = sut.state.featureToggles[0]
        XCTAssertTrue(featureToToggle.isEnabled)
        
        // When
        sut.toggleFeature(featureToToggle)
        
        // Then
        XCTAssertFalse(sut.state.featureToggles[0].isEnabled)
    }
    
    func test_toggleFeature_onlyTogglesTargetedFeature() {
        // Given
        mockFeatureSwitchWorker.storedToggles = [
            BHRFeatureToggle(featureName: "feature_a", isEnabled: false),
            BHRFeatureToggle(featureName: "feature_b", isEnabled: false),
            BHRFeatureToggle(featureName: "feature_c", isEnabled: true)
        ]
        sut = EnvironmentSettingsViewModel(
            environmentStore: mockEnvironmentStore,
            featureSwitchWorker: mockFeatureSwitchWorker
        )
        let featureB = sut.state.featureToggles[1]
        
        // When
        sut.toggleFeature(featureB)
        
        // Then - only feature_b should change
        XCTAssertFalse(sut.state.featureToggles[0].isEnabled, "feature_a should remain unchanged")
        XCTAssertTrue(sut.state.featureToggles[1].isEnabled, "feature_b should be toggled")
        XCTAssertTrue(sut.state.featureToggles[2].isEnabled, "feature_c should remain unchanged")
    }
    
    func test_toggleFeature_persistsToWorker() {
        // Given
        mockFeatureSwitchWorker.storedToggles = [
            BHRFeatureToggle(featureName: "feature_a", isEnabled: false)
        ]
        sut = EnvironmentSettingsViewModel(
            environmentStore: mockEnvironmentStore,
            featureSwitchWorker: mockFeatureSwitchWorker
        )
        let initialCallCount = mockFeatureSwitchWorker.setFeatureTogglesCallCount
        
        // When
        sut.toggleFeature(sut.state.featureToggles[0])
        
        // Then
        XCTAssertEqual(mockFeatureSwitchWorker.setFeatureTogglesCallCount, initialCallCount + 1)
        XCTAssertTrue(mockFeatureSwitchWorker.storedToggles[0].isEnabled)
    }
    
    func test_toggleFeature_withNonExistentFeature_doesNothing() {
        // Given
        mockFeatureSwitchWorker.storedToggles = [
            BHRFeatureToggle(featureName: "feature_a", isEnabled: false)
        ]
        sut = EnvironmentSettingsViewModel(
            environmentStore: mockEnvironmentStore,
            featureSwitchWorker: mockFeatureSwitchWorker
        )
        let nonExistentFeature = FeatureToggle(id: "non_existent", displayName: "Non Existent", isEnabled: false)
        let initialCallCount = mockFeatureSwitchWorker.setFeatureTogglesCallCount
        
        // When
        sut.toggleFeature(nonExistentFeature)
        
        // Then - no changes should occur
        XCTAssertEqual(mockFeatureSwitchWorker.setFeatureTogglesCallCount, initialCallCount)
        XCTAssertFalse(sut.state.featureToggles[0].isEnabled)
    }
    
    // MARK: - enabledOverrides Tests
    
    func test_enabledOverrides_returnsOnlyEnabledFeatures() {
        // Given
        mockFeatureSwitchWorker.storedToggles = [
            BHRFeatureToggle(featureName: "enabled_1", isEnabled: true),
            BHRFeatureToggle(featureName: "disabled_1", isEnabled: false),
            BHRFeatureToggle(featureName: "enabled_2", isEnabled: true),
            BHRFeatureToggle(featureName: "disabled_2", isEnabled: false)
        ]
        sut = EnvironmentSettingsViewModel(
            environmentStore: mockEnvironmentStore,
            featureSwitchWorker: mockFeatureSwitchWorker
        )
        
        // When
        let enabledOverrides = sut.enabledOverrides
        
        // Then
        XCTAssertEqual(enabledOverrides.count, 2)
        XCTAssertTrue(enabledOverrides.allSatisfy { $0.isEnabled })
        XCTAssertEqual(enabledOverrides[0].id, "enabled_1")
        XCTAssertEqual(enabledOverrides[1].id, "enabled_2")
    }
    
    func test_enabledOverrides_returnsEmptyWhenNoneEnabled() {
        // Given
        mockFeatureSwitchWorker.storedToggles = [
            BHRFeatureToggle(featureName: "disabled_1", isEnabled: false),
            BHRFeatureToggle(featureName: "disabled_2", isEnabled: false)
        ]
        sut = EnvironmentSettingsViewModel(
            environmentStore: mockEnvironmentStore,
            featureSwitchWorker: mockFeatureSwitchWorker
        )
        
        // When
        let enabledOverrides = sut.enabledOverrides
        
        // Then
        XCTAssertTrue(enabledOverrides.isEmpty)
    }
    
    func test_enabledOverrides_updatesAfterToggle() {
        // Given
        mockFeatureSwitchWorker.storedToggles = [
            BHRFeatureToggle(featureName: "feature_a", isEnabled: false)
        ]
        sut = EnvironmentSettingsViewModel(
            environmentStore: mockEnvironmentStore,
            featureSwitchWorker: mockFeatureSwitchWorker
        )
        XCTAssertTrue(sut.enabledOverrides.isEmpty)
        
        // When
        sut.toggleFeature(sut.state.featureToggles[0])
        
        // Then
        XCTAssertEqual(sut.enabledOverrides.count, 1)
        XCTAssertEqual(sut.enabledOverrides[0].id, "feature_a")
    }
}
