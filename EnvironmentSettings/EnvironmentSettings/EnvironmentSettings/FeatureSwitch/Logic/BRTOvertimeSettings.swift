import Foundation

class BRTOvertimeSettings {
  let featureToggles: [BHRFeatureToggle]

  init(dto: BRTOvertimeSettingsDTO) {
    var toggles = [BHRFeatureToggle]()
    toggles.append(BHRFeatureToggle(featureName: "toilEnabled", isEnabled: dto.enabled))
    toggles.append(BHRFeatureToggle(featureName: "loggingOwnToilAbsence", isEnabled: dto.useOwnToil))
    toggles.append(BHRFeatureToggle(featureName: "allowRecordingOwnToilEarned", isEnabled: dto.allowLoggingOwn))
    self.featureToggles = toggles
  }
}
