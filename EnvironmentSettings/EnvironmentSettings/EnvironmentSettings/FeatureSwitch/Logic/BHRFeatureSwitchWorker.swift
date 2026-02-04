import Foundation

protocol FeatureSwitchTesting {
  func isEnabledFeature(_ featureName: String) -> Bool
}

protocol BHRFeatureSwitchWorkerProtocol: FeatureSwitchTesting {
  func setFeatureToggles(_ featureToggles: [BHRFeatureToggle])
  func getFeatureToggles() -> [BHRFeatureToggle]?
  func getFeatureOverridePreference() -> Bool
  func setFeatureTogglesFromJson(_ json: [String: Bool])
  func updateFeatureOverride(isOn: Bool)
}

class BHRFeatureSwitchWorker: BHRFeatureSwitchWorkerProtocol {
  private var featureSwitchRepository: BHRFeatureSwitchRepositoryProtocol = BHRFeatureSwitchRepository()

  func setFeatureToggles(_ featureToggles: [BHRFeatureToggle]) {
    featureSwitchRepository.setFeatureToggles(featureToggles)
  }

  func getFeatureToggles() -> [BHRFeatureToggle]? {
    featureSwitchRepository.getFeatureToggles()
  }

  func getFeatureOverridePreference() -> Bool {
    featureSwitchRepository.getFeatureOverridePreference()
  }

  func setFeatureTogglesFromJson(_ json: [String: Bool]) {
    let featureToggles = json.compactMap(BHRFeatureToggle.init)
    featureSwitchRepository.setFeatureToggles(featureToggles)
  }

  func isEnabledFeature(_ featureName: String) -> Bool {
    guard let featureToggles = featureSwitchRepository.getFeatureToggles() else {
      return false
    }

    for featureToggle in featureToggles where featureToggle.featureName == featureName {
      return featureToggle.isEnabled
    }

    return false
  }

  func updateFeatureOverride(isOn: Bool) {
    featureSwitchRepository.updateFeatureOverride(isOn: isOn)
  }
}
