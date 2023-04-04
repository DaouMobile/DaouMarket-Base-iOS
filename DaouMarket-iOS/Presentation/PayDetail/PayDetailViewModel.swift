import UIKit
import Combine

final class PayDetailViewModel {
	init(totalCount: Int, totalPrice: Int, dependency: ProductDependency) {
		self.dependency = dependency
		self.totalCount = totalCount
		self.totalPrice = totalPrice
	}

	private let dependency: ProductDependency

	let totalCount: Int
	let totalPrice: Int

	private var receiverName: String = ""
	private var receiverPhoneNumber: String = ""
	private var ordererName: String = ""
	private var ordererPhoneNumber: String = ""

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
}
