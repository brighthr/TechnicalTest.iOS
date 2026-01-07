import Foundation
import OSLog

public protocol EnvironmentStoring: AnyObject {
  var activeEnvironment: EnvironmentName { get set }
}

public final class EnvironmentStore: EnvironmentStoring {
  public static let shared: EnvironmentStoring = DevelopmentEnvironmentStore(userDefaults: .standard)

  private let base: EnvironmentStoring

  public init(base: EnvironmentStoring) {
    self.base = base
  }

  public var activeEnvironment: EnvironmentName {
    get {
      base.activeEnvironment
    }

    set {
      base.activeEnvironment = newValue
    }
  }
}

private class ProductionEnvironmentStore: EnvironmentStoring {
  var activeEnvironment: EnvironmentName {
    get {
      .live
    }

    set {
      _ = newValue
    }
  }
}

private class DevelopmentEnvironmentStore: EnvironmentStoring {
  private let userDefaults: UserDefaults
  private let key = "BRTActiveDevelopmentEnvironmentKey"

  init(userDefaults: UserDefaults) {
    self.userDefaults = userDefaults
    userDefaults.register(defaults: [key: EnvironmentName.uat.rawValue])
  }

  var activeEnvironment: EnvironmentName {
    get {
      userDefaults.string(forKey: key).flatMap(EnvironmentName.init(rawValue:)) ?? .uat
    }

    set {
//      Logger.network.debug(string: "Setting active development environment to: \(newValue)")
      userDefaults.set(newValue.rawValue, forKey: key)
    }
  }
}
