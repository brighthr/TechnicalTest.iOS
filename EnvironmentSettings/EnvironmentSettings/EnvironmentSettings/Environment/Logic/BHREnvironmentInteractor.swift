import UIKit

protocol BHREnvironmentInteractorProtocol {
  func getEnviroments()
  func updateCurrentEndPoint(index: Int)
  func updateOAuthSelection(index: Int)
  func updateFeatureSwitch(index: Int, isOn: Bool)
  func updateFeatureOverride(isOn: Bool)
}

class BHREnvironmentInteractor: BHREnvironmentInteractorProtocol {
    var presenter: BHREnvironmentPresenterProtocol!
    lazy var environmentStore: EnvironmentStoring = EnvironmentStore.shared
    var featureSwitchWorker: BHRFeatureSwitchWorkerProtocol = BHRFeatureSwitchWorker()
    
    private var endpoints: [BHREndPoint] = []
    var features: [BHRFeatureToggle]?
    
    var defaultFeatureToggles: [BHRFeatureToggle] = [.init(featureName: BHRFeatureSwitch.praise, isEnabled: false)]
    
    private let oAuthEnvironments: [(environment: EnvironmentName, endpoint: BHREndPoint)] = EnvironmentName.allCases
        .map { environment in
            let oAuthEnvironment = BRTOAuthEnvironment(named: environment)
            return (
                environment,
                BHREndPoint(name: oAuthEnvironment.description, basedURL: oAuthEnvironment.baseURL.absoluteString)
            )
        }
    
    func getEnviroments() {
        features = featureSwitchWorker.getFeatureToggles()
        if features == nil || features?.isEmpty == true {
            features = defaultFeatureToggles
            featureSwitchWorker.setFeatureToggles(defaultFeatureToggles)
        }
        let isFeatureOverrideOn = featureSwitchWorker.getFeatureOverridePreference()
        
        presenter.present(endPoints: endpoints,
                          active: .init(name: "", basedURL: ""),
                          isFeatureOverrideOn: isFeatureOverrideOn,
                          features: features!)
    }
    
    func updateCurrentEndPoint(index: Int) {
        let selectedEnvironment = endpoints[index]
        
        presenter.present(endPoints: endpoints,
                          active: selectedEnvironment,
                          isFeatureOverrideOn: false,
                          features: features!)
    }
    
    func updateOAuthSelection(index: Int) {
        let (activeEnvironment, activeEndpoint) = oAuthEnvironments[index]
        
        environmentStore.activeEnvironment = activeEnvironment
        presenter.present(active: activeEndpoint)
    }
    
    func updateFeatureSwitch(index: Int, isOn: Bool) {
        guard var features else { return }
        for idx in 0 ... features.count where idx == index {
            features[idx].isEnabled = isOn
        }
        
        featureSwitchWorker.setFeatureToggles(features)
    }
    
    func updateFeatureOverride(isOn: Bool) {
        featureSwitchWorker.updateFeatureOverride(isOn: isOn)
        getEnviroments()
    }
}
