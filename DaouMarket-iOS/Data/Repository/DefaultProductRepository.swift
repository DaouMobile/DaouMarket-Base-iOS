import Foundation
import Combine
import Alamofire

final class DefaultProductRepository: ProductRepository {
	private var isLastPage: Bool = false

	func getProducts(page: Int) -> AnyPublisher<[Product], Error> {
		guard !isLastPage else {
			return Fail(error: DataLayerError.repositoryError(reason: .isLastPage))
				.eraseToAnyPublisher()
		}
		
		let response: AnyPublisher<ProductPageResponse, Error> = ProductNetworkAPI
			.getProducts(page: page, size: 20)
			.request()
			.eraseToAnyPublisher()

		return response
			.handleEvents(receiveOutput: { [weak self] (response) in
				self?.isLastPage = response.last
			})
			.map(\.content)
			.eraseToAnyPublisher()
	}

	func postOrder(order: OrderRequest) -> AnyPublisher<OrderResult, Error> {
		let response: AnyPublisher<OrderResponse, Error> = ProductNetworkAPI
			.postOrder(order: order)
			.request(encoding: JSONEncoding.default)
			.eraseToAnyPublisher()

		return response
			.map({ (response) -> OrderResult in
				return .init(
					code: response.code,
					id: response.id,
					paymentDate: response.paymentDate,
					totalPrice: response.totalPrice
				)
			})
			.eraseToAnyPublisher()
	}
}
