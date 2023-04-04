import UIKit
import Combine

extension UITextField {
	var textPublisher: AnyPublisher<String?, Never> {
		Publishers.ControlProperty(control: self, events: .defaultValueEvents, keyPath: \.text)
				  .eraseToAnyPublisher()
	}
}
