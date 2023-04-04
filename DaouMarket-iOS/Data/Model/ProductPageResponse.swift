import Foundation

struct ProductPageResponse: Decodable {
	let content: [Product]
	let empty: Bool
	let first: Bool
	let last: Bool
	let number: Int
	let numberOfElements: Int
	let pageable: Page
	let size: Int
	let sort: Sort
	let totalElements: Int
	let totalPages: Int
}

struct Sort: Decodable {
	let empty: Bool
	let sorted: Bool
	let unsorted: Bool
}

struct Page: Decodable {
	let page: Int
	let size: Int
}
