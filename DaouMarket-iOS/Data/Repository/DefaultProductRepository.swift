import Foundation
import Combine

final class DefaultProductRepository: ProductRepository {
	func getProducts(page: Int, size: Int) -> AnyPublisher<[Product], Error> {
		let response: AnyPublisher<ProductPageResponse, Error> = ProductNetworkAPI
			.getProducts(page: page, size: size)
			.request()
			.eraseToAnyPublisher()

		return response
			.map(\.content)
			.eraseToAnyPublisher()
	}
}
