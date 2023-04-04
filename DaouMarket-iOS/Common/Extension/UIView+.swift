import UIKit

extension UIView {
	func roundCorners(
	  _ radius: CGFloat,
	  corners: CACornerMask = [
		.layerMinXMinYCorner,
		.layerMinXMaxYCorner,
		.layerMaxXMinYCorner,
		.layerMaxXMaxYCorner
	  ]
	) {
		layer.cornerCurve = .continuous
		layer.cornerRadius = radius
		layer.maskedCorners = corners
		clipsToBounds = true
	}
}
