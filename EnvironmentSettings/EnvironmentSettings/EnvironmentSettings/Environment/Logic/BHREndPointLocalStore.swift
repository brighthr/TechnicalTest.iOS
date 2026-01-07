
import Foundation

public protocol BHREndPointLocalStoreProtocol {
  func getCurrentEndpointName() -> String?
  func setCurrentEndPointName(name: String)
  func getAllEndPoints() -> [BHREndPoint]
}

public final class BHREndPointLocalStore: BHREndPointLocalStoreProtocol {
  // MARK: - Nested Types

  private enum Constant {
    static let fileName = "EndPoint"
    static let fileType = "plist"
    static let savedEndPointKey = "EndPoint"
  }

  // MARK: - Private Properties

  private let userDefaults: UserDefaults

  // MARK: - Initializers

  public init(userDefaults: UserDefaults) {
    self.userDefaults = userDefaults
  }

  public convenience init?(appGroup: AppGroup) {
    guard let userDefaults = UserDefaults(suiteName: appGroup.rawValue) else { return nil }
    self.init(userDefaults: userDefaults)
  }

  // MARK: - Public Methods

  public func getCurrentEndpointName() -> String? {
    userDefaults.string(forKey: Constant.savedEndPointKey)
  }

  public func setCurrentEndPointName(name: String) {
    userDefaults.set(name, forKey: Constant.savedEndPointKey)
    userDefaults.synchronize()
  }

  public func getAllEndPoints() -> [BHREndPoint] {
    guard let path = Bundle(for: Self.self).path(forResource: Constant.fileName, ofType: Constant.fileType) else {
      fatalError("Missing Endpoint plist file")
    }

    guard let endpointDict = NSDictionary(contentsOfFile: path) as? [String: String] else {
      fatalError("Error in Endpoint content")
    }

    return endpointDict.compactMap(BHREndPoint.init).sorted { aDic, bDic -> Bool in
      aDic.name < bDic.name
    }
  }
}
