import Foundation
import Combine

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
}
