
import UIKit

typealias SwitchCallBack = (Bool) -> Void

class BHRSwitchCell: UITableViewCell {
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var buttonSwitch: UISwitch!

  var callBack: SwitchCallBack?

  var viewModel: BHRFeatureSwitchViewModel! {
    didSet {
      titleLabel.text = viewModel.featureName
      buttonSwitch.isOn = viewModel.isEnabled
    }
  }

  @IBAction func switchValueChanged(_ sender: UISwitch) {
    guard let callBack else {
      return
    }

    callBack(sender.isOn)
  }

  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}
