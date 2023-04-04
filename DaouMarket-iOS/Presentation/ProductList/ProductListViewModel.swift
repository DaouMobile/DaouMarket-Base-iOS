import UIKit
import Combine

final class ProductListViewModel {
	init(dependency: ProductDependency) {
		self.dependency = dependency
		bind()
	}

	private let dependency: ProductDependency
	private var cancellables: Set<AnyCancellable> = .init()

	private let searchedTermSubject: CurrentValueSubject<String?, Never> = .init(nil)

	private let productsSubject: CurrentValueSubject<[Product], Never> = .init([])
	var filteredProductsPublisher: AnyPublisher<[Product], Never> {
		return Publishers.CombineLatest(
			searchedTermSubject.eraseToAnyPublisher(),
			productsSubject.eraseToAnyPublisher()
		).map({ (searchedTerm, products) -> [Product] in
			guard let searchedTerm, !searchedTerm.isEmpty else { return products }
			return products.filter({ $0.content.contains(searchedTerm) })
		})
		.eraseToAnyPublisher()
	}

	func updateSearchedTerm(term: String) {
		searchedTermSubject.send(term)
	}

	private func bind() {
		dependency.productRepository.getProducts(page: 0)
			.sink(
				receiveCompletion: { (error) in
					print(error)
				},
				receiveValue: productsSubject.send(_:)
			)
			.store(in: &cancellables)
	}
}
