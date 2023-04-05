import Foundation

extension String {
	func toDate() -> Date? {
		let formatter: DateFormatter = .init()
		formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
		formatter.timeZone = .autoupdatingCurrent
		formatter.locale = .current
		formatter.calendar = .init(identifier: .gregorian)
		return formatter.date(from: self)
	}
}
