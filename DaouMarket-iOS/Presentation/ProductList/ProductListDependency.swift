protocol ProductListDependency {
	var productRepository: ProductRepository { get }
}

struct DefaultProductListDependency: ProductListDependency {
	init(_ productRepository: ProductRepository) {
		self.productRepository = productRepository
	}

	let productRepository: ProductRepository
}
