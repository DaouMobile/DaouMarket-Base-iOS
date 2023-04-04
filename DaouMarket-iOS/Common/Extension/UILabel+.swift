import UIKit

extension UILabel {
	func set(text: String? = nil, font: UIFont, textColor: UIColor) {
		if let text { self.text = text }
		self.font = font
		self.textColor = textColor
	}
}
