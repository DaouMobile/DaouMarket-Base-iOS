import Combine

protocol ProductRepository {
	func getProducts(page: Int, size: Int) -> AnyPublisher<[Product], Error>
}

extension ProductRepository {
	func getProducts(page: Int, size: Int = 20) -> AnyPublisher<[Product], Error> {
		return getProducts(page: page, size: size)
	}
}

