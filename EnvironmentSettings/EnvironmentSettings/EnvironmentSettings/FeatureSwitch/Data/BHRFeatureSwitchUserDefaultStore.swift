
import Foundation

final class BHRFeatureSwitchUserDefaultStore: BHRFeatureSwitchRepositoryProtocol {
  static let kFeatureTogglesKey = "FeatureToggles"
  static let kFeatureOverridePreference = "FeatureOverridePreference"

  private let userDefaults: UserDefaults

  init(userDefaults: UserDefaults = .standard) {
    self.userDefaults = userDefaults
  }

  func getFeatureToggles() -> [BHRFeatureToggle]? {
    guard let savedData = userDefaults.data(forKey: Self.kFeatureTogglesKey) else { return nil }
    do {
      return try JSONDecoder().decode([BHRFeatureToggle].self, from: savedData)
    } catch {
//      Telemetry.application.record(error: error, message: "BHRFeatureSwitchUserDefaultStore getFeatureToggles error")
      return nil
    }
  }

  func setFeatureToggles(_ featureToggles: [BHRFeatureToggle]?) {
    guard let featureToggles else {
      userDefaults.removeObject(forKey: Self.kFeatureTogglesKey)
      return
    }

    do {
      let featureToggleData = try JSONEncoder().encode(featureToggles)
      userDefaults.set(featureToggleData, forKey: Self.kFeatureTogglesKey)
    } catch {
//      Telemetry.application.record(error: error, message: "BHRFeatureSwitchUserDefaultStore setFeatureToggles error")
    }
  }

  func fetchFeatureToggles(completion _: @escaping (Error?, [BHRFeatureToggle]?) -> Void) {}

  func getFeatureOverridePreference() -> Bool {
    userDefaults.bool(forKey: Self.kFeatureOverridePreference)
  }

  func updateFeatureOverride(isOn: Bool) {
    userDefaults.set(isOn, forKey: Self.kFeatureOverridePreference)
  }
}
