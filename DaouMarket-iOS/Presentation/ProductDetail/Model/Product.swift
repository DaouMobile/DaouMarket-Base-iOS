import Foundation

struct Product: Decodable, Hashable {
	let id: Int
	let code: String
	let brand: String
	let content: String
	let imgUrl: String
	let inventory: Int
	let name: String
	let price: Int
	let summary: String
}
