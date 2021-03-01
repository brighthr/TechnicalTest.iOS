//
// Created by Alex Jackson on 01/03/2021.
//

import Foundation
import UIKit

final class PostDetailsViewController: UIViewController {

    // MARK: - Properties

    var post: Post!

    @IBOutlet private(set) var titleLabel: UILabel!
    @IBOutlet private(set) var bodyLabel: UILabel!

    // MARK: - UIViewController Overrides

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Post"
        titleLabel.text = post.title
        bodyLabel.text = post.body
    }
}
