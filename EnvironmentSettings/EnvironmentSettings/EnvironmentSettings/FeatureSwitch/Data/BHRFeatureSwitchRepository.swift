
import Foundation

protocol BHRFeatureSwitchRepositoryProtocol {
  func setFeatureToggles(_ featureToggles: [BHRFeatureToggle]?)
  func getFeatureToggles() -> [BHRFeatureToggle]?
  func getFeatureOverridePreference() -> Bool
  func updateFeatureOverride(isOn: Bool)
}

class BHRFeatureSwitchRepository: BHRFeatureSwitchRepositoryProtocol {
  var userDefaultStore = BHRFeatureSwitchUserDefaultStore()

  func setFeatureToggles(_ featureToggles: [BHRFeatureToggle]?) {
    userDefaultStore.setFeatureToggles(featureToggles)
    
      if (featureToggles?.first(where: { $0.featureName == BHRFeatureSwitch.sicknessPaidCertified })) != nil {
    }
  }

  func addNewFeatureSwitch() -> [BHRFeatureToggle] {
    [
      // Add new feature switch here
      BHRFeatureToggle(featureName: BHRFeatureSwitch.documentSearch, isEnabled: true),
      BHRFeatureToggle(featureName: BHRFeatureSwitch.accrualVariableANZ, isEnabled: true),
      BHRFeatureToggle(featureName: BHRFeatureSwitch.sicknessPaidCertified, isEnabled: false),
      BHRFeatureToggle(featureName: BHRFeatureSwitch.returnToWork, isEnabled: false)
    ]
  }

  func getFeatureToggles() -> [BHRFeatureToggle]? {
    guard let featureToggles = userDefaultStore.getFeatureToggles() else {
      return addNewFeatureSwitch()
    }

    // Return feature toggles from user default
    return featureToggles
  }

  func getFeatureOverridePreference() -> Bool {
    userDefaultStore.getFeatureOverridePreference()
  }

  func updateFeatureOverride(isOn: Bool) {
    userDefaultStore.updateFeatureOverride(isOn: isOn)
  }
}
