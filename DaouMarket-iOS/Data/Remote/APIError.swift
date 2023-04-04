import Foundation

enum APIError: LocalizedError {
	case responseValueIsNil

	var errorDescription: String? {
		switch self {
			case .responseValueIsNil:
				return "response value is nil"
		}
	}
}
