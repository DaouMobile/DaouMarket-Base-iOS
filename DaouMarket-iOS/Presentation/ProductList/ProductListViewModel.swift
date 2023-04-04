import UIKit
import Combine

final class ProductListViewModel {
	init(coordinator: ProductListCoordinator, dependency: ProductListDependency) {
		self.coordinator = coordinator
		self.dependency = dependency

		bind()
	}

	private let coordinator: ProductListCoordinator
	private let dependency: ProductListDependency
	private var cancellables: Set<AnyCancellable> = .init()

	private let searchedTermSubject: CurrentValueSubject<String?, Never> = .init(nil)

	private let productsSubject: CurrentValueSubject<[Product], Never> = .init([])
	var filteredProductsPublisher: AnyPublisher<[Product], Never> {
		return Publishers.CombineLatest(
			searchedTermSubject.eraseToAnyPublisher(),
			productsSubject.eraseToAnyPublisher()
		).map({ (searchedTerm, products) -> [Product] in
			guard let searchedTerm else { return products }
			return products.filter({ $0.name.contains(searchedTerm) })
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
				receiveValue: { [weak self] (products) in
					self?.productsSubject.send(products)
				}
			)
			.store(in: &cancellables)
	}
}
