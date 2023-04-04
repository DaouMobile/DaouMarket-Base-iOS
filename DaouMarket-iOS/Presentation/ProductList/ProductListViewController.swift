import UIKit
import Combine

final class ProductListViewController: UIViewController {
	init() {
		super.init(nibName: nil, bundle: nil)
		bind()
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private var cancellables: Set<AnyCancellable> = .init()

	func initViews() {
		view.backgroundColor = .yellow
	}

	func bind() {
		let productRepository: ProductRepository = get()
		productRepository.getProducts(page: 0)
			.sink(
				receiveCompletion: { (error) in
					print(error)
				},
				receiveValue: { (products) in
					print(products)
				}
			)
			.store(in: &cancellables)
	}
}
