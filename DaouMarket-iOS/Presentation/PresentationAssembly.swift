import Foundation
import Swinject
import Alamofire

final class PresentationAssembly: Assembly {
	func assemble(container: Container) {
		container.register(ProductDependency.self) { _ in
			return DefaultProductDependency(get())
		}
	}
}
