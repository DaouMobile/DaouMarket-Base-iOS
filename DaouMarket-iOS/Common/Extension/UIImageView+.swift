import UIKit
import Kingfisher

extension UIImageView {
	func setImage(source: Kingfisher.Source) {
		kf.setImage(
			with: source,
			placeholder: UIImage(named: "noImage"),
			options: [.transition(.fade(0.5))]
		)
	}
}
