import UIKit
import Combine

final class PayDetailViewModel {
	init(totalCount: Int, totalPrice: Int, products: [Product], dependency: ProductDependency) {
		self.dependency = dependency
		self.products = products
		self.totalCount = totalCount
		self.totalPrice = totalPrice
	}

	private let dependency: ProductDependency

	let products: [Product]
	let totalCount: Int
	let totalPrice: Int

	let receiverAddress: String = "(16878) 경기도 용인시 수지구 디지털밸리로 81"
	private var receiverName: String = ""
	private var receiverPhoneNumber: String = ""
	private var ordererName: String = ""
	private var ordererPhoneNumber: String = ""
	private var requestForDeliever: String = ""

	func setReceiverName(_ value: String) {
		receiverName = value
	}

	func setReceiverPhoneNumber(_ value: String) {
		receiverPhoneNumber = value
	}

	func setOrdererName(_ value: String) {
		ordererName = value
	}

	func setOrdererPhoneNumber(_ value: String) {
		ordererPhoneNumber = value
	}

	func setRequestForDelivery(_ value: String) {
		requestForDeliever = value
	}

	func order() -> AnyPublisher<OrderResult, Error> {
		let orderRequest: OrderRequest = .init(
			orderItems: [.init(
				productCode: products.first?.code ?? "",
				productPrice: products.first?.price ?? 0,
				quantity: totalCount,
				productOptions: [],
				additionalProduct: []
			)],
			orderPayment: .init(totalPrice: totalPrice),
			orderReceiver: .init(
				receiver: receiverName,
				receiverAddress: receiverAddress,
				receiverPhoneNumber: receiverPhoneNumber,
				requestForDelivery: requestForDeliever
			)
		)
		return dependency.productRepository.postOrder(order: orderRequest)
	}
}
