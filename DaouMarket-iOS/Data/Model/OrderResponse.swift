import Foundation

struct OrderResponse: Decodable {
	let code: String?
	let id: Int?
	let orderStatus: String?
	let paymentDate: String?
	let totalPrice: Int?
}
