import UIKit

final class CustomTextField: UITextField {
	init(placeholder: String? = nil) {
		super.init(frame: .zero)
		textAlignment = .left
		font = .systemFont(ofSize: 16, weight: .regular)
		textColor = .black
		backgroundColor = .white
		roundCorners(8)
		setBorder(width: 1, color: .lightGray)
		leftViewMode = .always
		leftView = .init(frame: .init(x: 0, y: 0, width: 16, height: 0))
		self.placeholder = placeholder
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
