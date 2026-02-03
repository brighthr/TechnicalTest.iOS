import UIKit

enum EnvironmentSection: Int {
    case oAuth, featureOverride, featureToggles
}

protocol BHREnvironmentViewControllerProtocol: AnyObject {
    func display(endPointNames: [String], active: String, sectionNumber: Int, isOverrideFeatureOn: Bool, features: [BHRFeatureSwitchViewModel])
    func display(active: String)
}

protocol BHREnvironmentViewProtocol: AnyObject {
    func showLegacyView()
    func setupOAuth(server: BRTOAuthEnvironment)
}

class BHREnvironmentViewController: UIViewController {
    var interactor: BHREnvironmentInteractorProtocol!
    
    fileprivate var endPointNames: [String] = []
    fileprivate var activeEndPoint: String = ""
    fileprivate var sectionNumber: Int = 0
    fileprivate var isOAuthLiveOn: Bool = false
    fileprivate var isOverrideFeatureOn: Bool = false
    fileprivate var featureViewModels: [BHRFeatureSwitchViewModel] = []
    
    private let oAuthNames = EnvironmentName.allCases
        .map(BRTOAuthEnvironment.init(named:))
        .map(\.description)
    
    private let oAuthEnvironments: [String: BRTOAuthEnvironment] = {
        let keyValuePairs = EnvironmentName.allCases.map { ($0.description, BRTOAuthEnvironment(named: $0)) }
        return Dictionary(uniqueKeysWithValues: keyValuePairs)
    }()
    
    weak var delegate: BHREnvironmentViewProtocol?
    
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Object lifecycle
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        let viewController = self
        let presenter = BHREnvironmentPresenter()
        presenter.viewController = viewController
        
        let interactor = BHREnvironmentInteractor()
        interactor.presenter = presenter
        
        viewController.interactor = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        interactor.getEnviroments()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    @IBAction func closeButtonPressed(_: Any) {
        dismiss(animated: true) { [self] in
            if let oAuthEnvironment = oAuthEnvironments[activeEndPoint] {
                delegate?.setupOAuth(server: oAuthEnvironment)
            } else {
                delegate?.showLegacyView()
            }
        }
    }
}

extension BHREnvironmentViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in _: UITableView) -> Int {
        sectionNumber
    }
    
    func tableView(_: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case EnvironmentSection.oAuth.rawValue:
            return "OAuth"
        case EnvironmentSection.featureOverride.rawValue:
            return "FeatureOverride"
        case EnvironmentSection.featureToggles.rawValue:
            return "Feature Toggles"
        default:
            return ""
        }
    }
    
    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case EnvironmentSection.oAuth.rawValue:
            return oAuthNames.count
        case EnvironmentSection.featureOverride.rawValue:
            return 1
        case EnvironmentSection.featureToggles.rawValue:
            return featureViewModels.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let switchCallBack: SwitchCallBack = { [weak self] switchIsOn in
            self?.switchValueChanged(switchIsOn, forRowAtIndexPath: indexPath)
        }
        
        switch indexPath.section {
        case EnvironmentSection.oAuth.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "environmentCell", for: indexPath)
            let oAuthName = oAuthNames[indexPath.row]
            cell.textLabel?.text = oAuthName
            cell.accessoryType = oAuthName == activeEndPoint ? .checkmark : .none
            return cell
            
        case EnvironmentSection.featureOverride.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "featureSwitchCell",
                                                           for: indexPath) as? BHRSwitchCell
            else {
                fatalError("Cell Indentifior does not match.")
            }
            cell.viewModel = BHRFeatureSwitchViewModel(featureName: "Override", isEnabled: isOverrideFeatureOn)
            cell.callBack = switchCallBack
            return cell
            
        case EnvironmentSection.featureToggles.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "featureSwitchCell",
                                                           for: indexPath) as? BHRSwitchCell
            else {
                fatalError("Cell Indentifior does not match.")
            }
            cell.viewModel = featureViewModels[indexPath.row]
            cell.callBack = switchCallBack
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == EnvironmentSection.oAuth.rawValue {
            interactor.updateOAuthSelection(index: indexPath.row)
        }
    }
}

extension BHREnvironmentViewController: BHREnvironmentViewControllerProtocol {
  // MARK: - Display logic

  func display(endPointNames: [String],
               active: String,
               sectionNumber: Int,
               isOverrideFeatureOn: Bool,
               features: [BHRFeatureSwitchViewModel]) {
    self.endPointNames = endPointNames
    activeEndPoint = active
    featureViewModels = features
    self.sectionNumber = sectionNumber
    self.isOverrideFeatureOn = isOverrideFeatureOn

    tableView.reloadData()
  }

  func display(active: String) {
    activeEndPoint = active
    tableView.reloadData()
  }
}

extension BHREnvironmentViewController {
  func switchValueChanged(_ isOn: Bool, forRowAtIndexPath indexPath: IndexPath) {
    if indexPath.section == EnvironmentSection.featureOverride.rawValue {
      interactor.updateFeatureOverride(isOn: isOn)
    } else if indexPath.section == EnvironmentSection.oAuth.rawValue {
      interactor.updateOAuthSelection(index: indexPath.row)
    } else {
      interactor.updateFeatureSwitch(index: indexPath.row, isOn: isOn)
    }
  }
}
