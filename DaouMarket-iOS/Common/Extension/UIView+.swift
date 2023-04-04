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

extension UIView {
	func setBorder(width: CGFloat, color: UIColor) {
		layer.borderWidth = width
		layer.borderColor = color.cgColor
	}
}

extension UIView {
	func tapEventPublisher(_ type: GestureType = .tap()) -> GesturePublisher {
		return .init(view: self, gestureType: type)
	}
}
