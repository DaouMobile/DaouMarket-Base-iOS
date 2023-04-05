import Foundation

extension Int {
	func formatNumber() -> String {
		let formatter = NumberFormatter()
		formatter.numberStyle = .decimal
		guard let numberString = formatter.string(from: .init(value: self)) else {
			return ""
		}
		return "\(numberString)원"
	}
}
