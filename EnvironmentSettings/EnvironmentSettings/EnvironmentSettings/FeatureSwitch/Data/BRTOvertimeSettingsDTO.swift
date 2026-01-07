
import Foundation

struct BRTOvertimeSettingsDTO: Codable {
  let enabled: Bool
  let allowLoggingOwn: Bool
  let useOwnToil: Bool
}

struct OvertimeSettings: Codable {
  let enabled: Bool
  let allowLoggingOwn: Bool
  let useOwnToil: Bool

  init(dto: BRTOvertimeSettingsDTO) {
    self.enabled = dto.enabled
    self.allowLoggingOwn = dto.allowLoggingOwn
    self.useOwnToil = dto.useOwnToil
  }
}
