import Foundation

struct OrderRequest: Codable {
	init(orderItems: [OrderItem], orderPayment: OrderPayment, orderReceiver: OrderReceiver, totalByDiscount: Int = 0) {
		self.orderItems = orderItems
		self.orderPayment = orderPayment
		self.orderReceiver = orderReceiver
		self.totalByDiscount = totalByDiscount
	}

	let orderItems: [OrderItem]
	let orderPayment: OrderPayment
	let orderReceiver: OrderReceiver
	let totalByDiscount: Int
}

struct OrderItem: Codable {
	let productCode: String
	let productPrice: Int
	let quantity: Int
	let productOptions: [OrderProduct]
	let additionalProduct: [OrderProduct]
}

struct OrderProduct: Codable {
	let id: Int
	let name: String
	let price: Int
	let quantity: Int
}

struct OrderPayment: Codable {
	internal init(cardType: String = "MASTER", discountPrice: Int = 0, installment: Bool = true, monthlyInstallation: Int = 0, payType: String = "TRANSPORT", totalPrice: Int) {
		self.cardType = cardType
		self.discountPrice = discountPrice
		self.installment = installment
		self.monthlyInstallation = monthlyInstallation
		self.payType = payType
		self.totalPrice = totalPrice
	}

	let cardType: String
	let discountPrice: Int
	let installment: Bool
	let monthlyInstallation: Int
	let payType: String
	let totalPrice: Int
}

struct OrderReceiver: Codable {
	let receiver: String
	let receiverAddress: String
	let receiverPhoneNumber: String
	let requestForDelivery: String
}

struct OrderResult {
	let code: String?
	let id: Int?
	let paymentDate: String?
	let totalPrice: Int?
}
