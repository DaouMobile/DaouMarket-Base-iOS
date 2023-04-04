import UIKit
import Combine
import SnapKit

final class ProductListViewController: UIViewController {
	typealias DataSource = UICollectionViewDiffableDataSource<ProductListKindsOfSection, Product>
	typealias Snapshot = NSDiffableDataSourceSnapshot<ProductListKindsOfSection, Product>

	init(viewModel: ProductListViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
		initViews()
		bind()
		setupSearchBarController()
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private var cancellables: Set<AnyCancellable> = .init()

	private let viewModel: ProductListViewModel

	private let searchBarController: SearchBarController = .init()

	private lazy var productsCollectionView: UICollectionView = {
		let layout: ProductListCollectionViewLayout = .init()
		let collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: layout)
		collectionView.showsVerticalScrollIndicator = false
		collectionView.delegate = self
		collectionView.register(
			ProductListCollectionViewCell.self,
			forCellWithReuseIdentifier: ProductListCollectionViewCell.reuseIdentifier
		)
		return collectionView
	}()

	private lazy var dataSource: DataSource! = {
		 return DataSource(
			collectionView: productsCollectionView,
			cellProvider: { (collectionView, indexPath, viewData) in
				guard let cell = collectionView.dequeueReusableCell(
					withReuseIdentifier: ProductListCollectionViewCell.reuseIdentifier,
					for: indexPath
				) as? ProductListCollectionViewCell else {
					return nil
				}
				cell.setup(viewData)
				return cell
			}
		 )
	}()

	private func initViews() {
		view.backgroundColor = .white

		view.addSubview(productsCollectionView)
		productsCollectionView.snp.makeConstraints { make in
			make.top.bottom.equalTo(view.safeAreaLayoutGuide)
			make.horizontalEdges.equalToSuperview()
		}
	}

	private func bind() {
		viewModel.filteredProductsPublisher
			.receive(on: DispatchQueue.main)
			.sink(receiveValue: applySnapshot(_:))
			.store(in: &cancellables)

		searchBarController.termPublisher
			.sink(receiveValue: viewModel.updateSearchedTerm(term:))
			.store(in: &cancellables)
	}

	private func setupSearchBarController() {
		navigationItem.searchController = searchBarController
		navigationItem.title = "Daou Store"
		navigationItem.hidesSearchBarWhenScrolling = false
		navigationItem.largeTitleDisplayMode = .always
		navigationItem.backButtonTitle = ""
	}

	private func applySnapshot(_ viewData: [Product]) {
		var snapshot: Snapshot = .init()
		snapshot.appendSections([.main])
		snapshot.appendItems(viewData, toSection: .main)
		dataSource.apply(snapshot, animatingDifferences: true)
	}
}

extension ProductListViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		guard let product = dataSource.snapshot().itemIdentifiers[safe: indexPath.row] else {
			return
		}
		let viewController: ProductDetailViewController = .init(product: product)
		viewController.modalPresentationStyle = .fullScreen
		navigationController?.pushViewController(viewController, animated: true)
	}
}
