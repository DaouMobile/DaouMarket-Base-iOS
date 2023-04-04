import Foundation
import Alamofire
import Combine

public protocol NetworkAPI {
	var scheme: String { get }
	var host: String { get }
	var path: String { get }
	var method: HTTPMethod { get}
	var headers: HTTPHeaders { get }
	var parameters: Parameters { get }
	var baseURL: URL? { get }
	var description: String { get }
}

public extension NetworkAPI {
	func request<Response: Decodable>(
		encoding: ParameterEncoding = URLEncoding.queryString,
		decoder: JSONDecoder = JSONDecoder()
	) -> AnyPublisher<Response, Error>
	{
		guard let url = baseURL?.appendingPathComponent(path) else {
			return Fail(error: AFError.invalidURL(url: description))
				.eraseToAnyPublisher()
		}

		let session: Session = get()
		return session.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
			.validate(statusCode: 200..<300)
			.publishDecodable(type: Response.self, queue: .global() ,decoder: decoder)
			.tryMap { response in
				if let error = response.error {
					throw error
				}
				if let value = response.value {
					print("response: \(value)")
					return value
				} else {
					throw APIError.responseValueIsNil
				}
			}
			.eraseToAnyPublisher()
	}
}
