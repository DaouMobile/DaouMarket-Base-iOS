import UIKit
import Combine

final class SearchBarController: UISearchController {
	init() {
		super.init(nibName: nil, bundle: nil)
		searchResultsUpdater = self
		searchBar.delegate = self
		searchBar.placeholder = "검색어를 입력해주세요."
		hidesNavigationBarDuringPresentation = false
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private let termSubject: CurrentValueSubject<String?, Never> = .init(nil)
	var termPublisher: AnyPublisher<String, Never> {
		return termSubject
			.compactMap({ $0 })
			.eraseToAnyPublisher()
	}
}

extension SearchBarController: UISearchResultsUpdating, UISearchBarDelegate {
	func updateSearchResults(for searchController: UISearchController) {
		guard let term = searchBar.text else {
			return
		}
		termSubject.send(term)
	}
}

