import Foundation
import UIKit

public struct BHREndPoint: Equatable {
  public let name: String
  public let basedURL: String

  public init(name: String, basedURL: String) {
    self.name = name
    self.basedURL = basedURL
  }
}

protocol BHREnvironmentPresenterProtocol: AnyObject {
  func present(endPoints: [BHREndPoint], active: BHREndPoint, isFeatureOverrideOn: Bool, features: [BHRFeatureToggle])
  func present(active: BHREndPoint)
}

class BHREnvironmentPresenter: BHREnvironmentPresenterProtocol {
  weak var viewController: BHREnvironmentViewControllerProtocol?

  // MARK: - Presentation logic

  // NOTE: Format the response from the Interactor and pass the result back to the View Controller
  func present(
    endPoints: [BHREndPoint] = [],
    active: BHREndPoint = BHREndPoint(name: "", basedURL: ""),
    isFeatureOverrideOn: Bool = false,
    features: [BHRFeatureToggle] = []
  ) {
    let endPointNames: [String] = endPoints.compactMap { $0.name }
    let featureViewModels = features.compactMap {
      BHRFeatureSwitchViewModel(featureName: $0.featureName, isEnabled: $0.isEnabled)
    }

    let sectionNumber = isFeatureOverrideOn ? 4 : 3
    viewController?.display(
      endPointNames: endPointNames,
      active: active.name,
      sectionNumber: sectionNumber,
      isOverrideFeatureOn: isFeatureOverrideOn,
      features: featureViewModels
    )
  }

  func present(active: BHREndPoint) {
    viewController?.display(active: active.name)
  }
}
