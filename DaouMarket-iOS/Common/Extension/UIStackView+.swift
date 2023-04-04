import UIKit

extension UIStackView {
	static func make(
		arrangedSubviews: [UIView] = [],
		axis: NSLayoutConstraint.Axis,
		alignment: Alignment,
		spacing: CGFloat,
		distribution: Distribution
	) -> UIStackView {
		let stackView: UIStackView = .init()
		stackView.axis = axis
		stackView.alignment = alignment
		stackView.spacing = spacing
		stackView.distribution = distribution
		stackView.addArrangeSubviews(arrangedSubviews)
		return stackView
	}

	func addArrangeSubviews(_ views: [UIView]) {
		for view in views {
			self.addArrangedSubview(view)
		}
	}
}
