import UIKit

final class ButtonWidgetView: UIButton {
	init() {
		super.init(frame: .zero)
		initView()
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private let mainStackView: UIStackView = {
		let stackView: UIStackView = .make(
			axis: .horizontal,
			alignment: .center,
			spacing: 16,
			distribution: .fill
		)
		return stackView
	}()

	func setupViews(_ views: [UIView]) {
		mainStackView.addArrangeSubviews(views)
	}

	private func initView() {
		addSubview(mainStackView)
		mainStackView.snp.makeConstraints { make in
			make.verticalEdges.equalToSuperview()
			make.centerX.equalToSuperview()
		}
	}
}
