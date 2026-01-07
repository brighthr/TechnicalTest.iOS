public struct AppGroup: Hashable, RawRepresentable {
  public let rawValue: String

  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  public init(_ rawValue: String) {
    self.rawValue = rawValue
  }

  public static let extensionGroup = AppGroup(rawValue: "group.app.extensions")
}
