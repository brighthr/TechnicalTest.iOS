

import UIKit

class ViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }

  @IBAction func switchButtonTapped(_: Any) {
    if let environmentVC = UIStoryboard(name: "Environment", bundle: nil).instantiateViewController(withIdentifier: "environmentNC") as? UINavigationController, let vc = environmentVC.topViewController as? BHREnvironmentViewController {
      self.present(environmentVC, animated: true, completion: nil)
    }
  }
}

