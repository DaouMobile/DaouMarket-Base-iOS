import UIKit

final class SpacerView: UIView {
	public init(axis: NSLayoutConstraint.Axis) {
		super.init(frame: .zero)

		backgroundColor = .clear
		setContentHuggingPriority(.defaultLow, for: axis)
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
