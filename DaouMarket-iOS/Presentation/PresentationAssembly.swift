import Foundation
import Swinject
import Alamofire

final class PresentationAssembly: Assembly {
	func assemble(container: Container) {
		container.register(ProductListDependency.self) { _ in
			return DefaultProductListDependency(get())
		}
	}
}
