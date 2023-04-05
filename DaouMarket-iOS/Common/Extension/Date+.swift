import Foundation

extension Date {
	func formatted(_ dateFormat: String) -> String {
		let dateFormatter: DateFormatter = .init()
		dateFormatter.dateFormat = dateFormat
		dateFormatter.timeZone = .autoupdatingCurrent
		dateFormatter.locale = .current
		dateFormatter.calendar = .init(identifier: .gregorian)
		return dateFormatter.string(from: self)
	}
}
