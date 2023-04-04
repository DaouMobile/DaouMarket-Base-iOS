import Foundation

struct ProductResponse: Decodable {
	let brand: String
	let code: String
	let content: String
	let id: Int
	let imgUrl: String
	let inventory: Int
	let name: String
	let price: Int
	let summary: String
}
