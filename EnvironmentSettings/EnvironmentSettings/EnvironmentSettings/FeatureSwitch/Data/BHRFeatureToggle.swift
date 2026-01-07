
import Foundation

enum BHRFeatureSwitch {
  static let newsFeed = "newsFeed"
  static let insight = "insights"
  static let toil = "toilEnabled"
  static let loggingOwnToilAbsence = "loggingOwnToilAbsence"
  static let allowRecordingOwnToilEarned = "allowRecordingOwnToilEarned"
  static let status = "status"
  static let oldRotaJourney = "oldRotaJourney"
  static let newDashboardExperiment = "New Dashboard Experiment"
  static let dashboardFeedbackCard = "Legacy Dashboard Feedback Card"
  static let praise = "praise"
  static let accrualVariableANZ = "accrualVariableANZ"
  static let documentSearch = "documentSearch"
  static let sicknessPaidCertified = "sicknessPaidCertified"
  static let returnToWork = "returnToWork"
}

struct BHRFeatureToggle: Codable, Equatable {
  let featureName: String
  var isEnabled: Bool = false
}
