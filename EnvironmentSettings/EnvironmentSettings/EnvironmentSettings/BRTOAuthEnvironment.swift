import Foundation

public struct BRTOAuthEnvironment: CustomStringConvertible {
  public let description: String
  public let baseURL: URL
  public let configurationFileURL: URL

  public init(description: String, baseURL: URL, configurationFileURL: URL) {
    self.description = description
    self.baseURL = baseURL
    self.configurationFileURL = configurationFileURL
  }
}

public enum EnvironmentName: String, CaseIterable, CustomStringConvertible {
  case live = "Live"
  case uat = "UAT"
  case qa01 = "QA01"
  case qa02 = "QA02"
  case qa03 = "QA03"
  case qa04 = "QA04"
  case qa05 = "QA05"
  case qa06 = "QA06"
  case qa07 = "QA07"

  public var description: String {
    rawValue
  }
}

private class Marker {}

extension BRTOAuthEnvironment {
  public init(named environmentName: EnvironmentName) {
    switch environmentName {
    case .live:
      self = .live
    case .uat:
      self = .uat
    case .qa01:
      self = .qa01
    case .qa02:
      self = .qa02
    case .qa03:
      self = .qa03
    case .qa04:
      self = .qa04
    case .qa05:
      self = .qa05
    case .qa06:
      self = .qa06
    case .qa07:
      self = .qa07
    }
  }

  private static let uat: BRTOAuthEnvironment = {
    let bundle = Bundle(for: Marker.self)
    guard let configFileURL = bundle.url(forResource: "oauth-uat", withExtension: "plist") else {
      preconditionFailure("UAT OAuth configuration file could not be found in \(bundle)")
    }

    let baseURL = URL(string: "https://bright.azurewebsites.net")!

    return BRTOAuthEnvironment(
      description: EnvironmentName.uat.rawValue,
      baseURL: baseURL,
      configurationFileURL: configFileURL
    )
  }()

  private static let live: BRTOAuthEnvironment = {
    let bundle = Bundle(for: Marker.self)
    guard let configFileURL = bundle.url(forResource: "oauth-live", withExtension: "plist") else {
      preconditionFailure("Live OAuth configuration file could not be found in \(bundle)")
    }

    let baseURL = URL(string: "https://bright.azurewebsites.net")!
    return BRTOAuthEnvironment(
      description: EnvironmentName.live.rawValue,
      baseURL: baseURL,
      configurationFileURL: configFileURL
    )
  }()

  private static let qaConfigFile: URL = {
    let bundle = Bundle(for: Marker.self)
    guard let configFileURL = bundle.url(forResource: "oauth-qa", withExtension: "plist") else {
      preconditionFailure("QA OAuth configuration file could not be found in \(bundle)")
    }

    return configFileURL
  }()

  private static let qa01 = BRTOAuthEnvironment(
    description: EnvironmentName.qa01.rawValue,
    baseURL: URL(string: "https://bright-qa01.azurewebsites.net")!,
    configurationFileURL: qaConfigFile
  )

  private static let qa02 = BRTOAuthEnvironment(
    description: EnvironmentName.qa02.rawValue,
    baseURL: URL(string: "https://bright-qa02.azurewebsites.net")!,
    configurationFileURL: qaConfigFile
  )

  private static let qa03 = BRTOAuthEnvironment(
    description: EnvironmentName.qa03.rawValue,
    baseURL: URL(string: "https://bright-qa03.azurewebsites.net")!,
    configurationFileURL: qaConfigFile
  )

  private static let qa04 = BRTOAuthEnvironment(
    description: EnvironmentName.qa04.rawValue,
    baseURL: URL(string: "https://bright-qa04.azurewebsites.net")!,
    configurationFileURL: qaConfigFile
  )

  private static let qa05 = BRTOAuthEnvironment(
    description: EnvironmentName.qa05.rawValue,
    baseURL: URL(string: "https://bright-qa05.azurewebsites.net")!,
    configurationFileURL: qaConfigFile
  )

  private static let qa06 = BRTOAuthEnvironment(
    description: EnvironmentName.qa06.rawValue,
    baseURL: URL(string: "https://bright-qa06.azurewebsites.net")!,
    configurationFileURL: qaConfigFile
  )

  private static let qa07 = BRTOAuthEnvironment(
    description: EnvironmentName.qa07.rawValue,
    baseURL: URL(string: "https://bright-qa07.azurewebsites.net")!,
    configurationFileURL: qaConfigFile
  )
}
