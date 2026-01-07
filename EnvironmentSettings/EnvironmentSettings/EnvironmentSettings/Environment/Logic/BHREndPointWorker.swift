import Foundation

protocol BHREndPointWorkerProtocol {
  func getEndPoint() -> BHREndPoint

  func getAllEndPoints() -> [BHREndPoint]?

  func setEndPoint(_ endPoint: BHREndPoint)
}

class BHREndPointWorker: BHREndPointWorkerProtocol {
  var endPointManager: BHREndPointManagerProtocol = BHREndPointManager()

  func getEndPoint() -> BHREndPoint {
    endPointManager.getEndPoint()
  }

  func getAllEndPoints() -> [BHREndPoint]? {
    endPointManager.getAllEndPoints()
  }

  func setEndPoint(_ endPoint: BHREndPoint) {
    endPointManager.setCurrentEndPointName(endPoint.basedURL)
  }
}

public protocol BHREndPointManagerProtocol {
  func getEndPoint() -> BHREndPoint
  func getBasedURL() -> String
  func getAllEndPoints() -> [BHREndPoint]
  func setCurrentEndPointName(_ name: String)
}

public class BHREndPointManager: NSObject, BHREndPointManagerProtocol {
  public var localStore: BHREndPointLocalStoreProtocol = {
    guard let userDefaults = UserDefaults(suiteName: AppGroup.extensionGroup.rawValue) else {
      preconditionFailure("Target must be a member of the \(AppGroup.extensionGroup) group")
    }

    return BHREndPointLocalStore(userDefaults: userDefaults)
  }()

  public func getEndPoint() -> BHREndPoint {
    let endpointName = localStore.getCurrentEndpointName() ?? ""

    return BHREndPoint(name: "", basedURL: endpointName)
  }

  public func getBasedURL() -> String {
    getEndPoint().basedURL
  }

  public func getAllEndPoints() -> [BHREndPoint] {
    localStore.getAllEndPoints()
  }

  public func setCurrentEndPointName(_ name: String) {
    localStore.setCurrentEndPointName(name: name)
  }
}
