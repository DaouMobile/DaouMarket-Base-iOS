import Combine

protocol ProductRepository {
	func getProducts(page: Int) -> AnyPublisher<[Product], Error>
	func postOrder(order: OrderRequest) -> AnyPublisher<OrderResult, Error>
}

extension ProductRepository {
	func getProducts(page: Int = 0) -> AnyPublisher<[Product], Error> {
		return getProducts(page: page)
	}
}

