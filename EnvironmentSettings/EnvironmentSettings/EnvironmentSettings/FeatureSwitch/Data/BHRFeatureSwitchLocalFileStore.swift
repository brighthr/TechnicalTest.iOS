
import Foundation

class BHRFeatureSwitchLocalFileStore {
  private enum Constant {
    static let fileName = "FeatureSwitch"
    static let fileType = "plist"
  }

  // MARK: BHRWhatNewStoreProtocol

  func getFeatureToggles() -> [BHRFeatureToggle]? {
    guard let path = Bundle.main.path(forResource: Constant.fileName, ofType: Constant.fileType) else {
      return nil
    }

    guard let featureSwitch = NSDictionary(contentsOfFile: path) as? [String: Bool] else {
      return nil
    }

    return featureSwitch.compactMap(BHRFeatureToggle.init)
  }
}
