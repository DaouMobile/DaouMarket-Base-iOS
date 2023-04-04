protocol ProductDependency {
	var productRepository: ProductRepository { get }
}

struct DefaultProductDependency: ProductDependency {
	init(_ productRepository: ProductRepository) {
		self.productRepository = productRepository
	}

	let productRepository: ProductRepository
}
