import Foundation

struct ProductPageResponse: Decodable {
	let content: [Product]
	let first: Bool
	let last: Bool
	let pageable: Pageable
}

struct Pageable: Decodable {
	let pageNumber: Int
}
