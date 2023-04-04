import Foundation
import Alamofire

enum ProductNetworkAPI: NetworkAPI {
	case getProducts(page: Int, size: Int)
	case postOrder(customerID: Int)

	var scheme: String {
		return "http"
	}

	var host: String {
		return "13.124.240.76:8080"
	}

	var path: String {
		switch self {
			case .getProducts:
				return "api/products"
			case .postOrder:
				return "api/order"
		}
	}

	var method: HTTPMethod {
		switch self {
			case .getProducts:
				return .get
			case .postOrder:
				return .post
		}
	}

	var headers: HTTPHeaders {
		return .default
	}

	var parameters: Parameters {
		switch self {
			case .getProducts(let page, let size):
				return [
					"page": page,
					"size": size
				]
			default:
				return [:]
		}
	}

	var baseURL: URL? {
		return URL(string: "\(scheme)://\(host)")
	}

	var description: String {
		return "\(scheme)://\(host)/\(path)?\(parameters)"
	}
}
