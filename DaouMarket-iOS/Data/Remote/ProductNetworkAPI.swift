import Foundation
import Alamofire

enum ProductNetworkAPI: NetworkAPI {
	case getProducts(page: Int, size: Int)

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
		}
	}

	var method: HTTPMethod {
		switch self {
			case .getProducts:
				return .get
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
		}
	}

	var baseURL: URL? {
		return URL(string: "\(scheme)://\(host)")
	}

	var description: String {
		return "\(scheme)://\(host)/\(path)?\(parameters)"
	}
}
