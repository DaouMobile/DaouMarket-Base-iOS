import Foundation
import Swinject
import Alamofire

final class DataAssembly: Assembly {
	func assemble(container: Container) {
		container.register(Session.self) { _ in
			let session: Session = .init(
				configuration: URLSessionConfiguration.af.default,
				interceptor: RetryPolicy.init()
			)
			return session
		}.inObjectScope(.container)

		container.register(ProductRepository.self) { _ in
			return DefaultProductRepository()
		}.inObjectScope(.container)
	}
}
