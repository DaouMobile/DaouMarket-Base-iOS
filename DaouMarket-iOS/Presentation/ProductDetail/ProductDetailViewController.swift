import UIKit
import Combine

final class ProductDetailViewController: UIViewController {
	init(product: Product) {
		self.product = product
		super.init(nibName: nil, bundle: nil)
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		setup(product)
		initViews()
		bind()
		setupSearchBarController()
	}

	private var cancellables: Set<AnyCancellable> = .init()
	private let product: Product

	private lazy var mainStackView: UIStackView = {
		let stackView: UIStackView = .make(
			arrangedSubviews: [
				thumbnailImageView,
				brandLabel,
				contentLabel,
				priceLabel,
				SpacerView(axis: .vertical)
			],
			axis: .vertical,
			alignment: .fill,
			spacing: 16,
			distribution: .fill
		)
		stackView.isLayoutMarginsRelativeArrangement = true
		stackView.layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
		return stackView
	}()

	private let thumbnailImageView: UIImageView = {
		let imageView: UIImageView = .init(image: .init(named: "noImage"))
		imageView.contentMode = .scaleAspectFit
		imageView.clipsToBounds = true
		imageView.snp.makeConstraints { make in
			make.size.equalTo(240)
		}
		return imageView
	}()

	private let brandLabel: UILabel = {
		let label: UILabel = .init()
		label.set(
			font: .systemFont(ofSize: 14, weight: .regular),
			textColor: .systemGray2
		)
		label.textAlignment = .left
		return label
	}()

	private let contentLabel: UILabel = {
		let label: UILabel = .init()
		label.set(
			font: .systemFont(ofSize: 14, weight: .regular),
			textColor: .black
		)
		label.textAlignment = .left
		return label
	}()

	private let priceLabel: UILabel = {
		let label: UILabel = .init()
		label.set(
			font: .systemFont(ofSize: 18, weight: .medium),
			textColor: .black
		)
		return label
	}()

	private let confirmButtonWidgetView: ButtonWidgetView = {
		let widgetView: ButtonWidgetView = .init()
		widgetView.roundCorners(16)
		widgetView.backgroundColor = .black
		let titleLabel: UILabel = .init()
		titleLabel.set(
			text: "구매하기",
			font: .systemFont(ofSize: 20, weight: .bold),
			textColor: .white
		)
		widgetView.setupViews([titleLabel])
		return widgetView
	}()

	private func initViews() {
		view.backgroundColor = .white

		[
			mainStackView,
			confirmButtonWidgetView
		].forEach({ view.addSubview($0) })

		confirmButtonWidgetView.snp.makeConstraints { make in
			make.height.equalTo(56)
			make.horizontalEdges.equalToSuperview().inset(16)
			make.bottom.equalTo(view.safeAreaLayoutGuide)
		}

		mainStackView.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
			make.horizontalEdges.equalToSuperview()
			make.bottom.equalTo(confirmButtonWidgetView.snp.top)
		}
	}

	private func bind() {
		confirmButtonWidgetView.tapEventPublisher()
			.map({ _ in })
			.sink(receiveValue: { [weak self] _ in
				guard let self else { return }
				let bottomSheetViewController: ProductDetailBottomSheetViewController = .init(
					name: self.product.name,
					price: self.product.price,
					completion: { (totalCount, totalPrice) in
						let viewModel: PayDetailViewModel = .init(totalCount: totalCount, totalPrice: totalPrice, products: [self.product], dependency: get())
						let viewController: PayDetailViewController = .init(viewModel: viewModel)
						viewController.modalPresentationStyle = .fullScreen
						self.navigationController?.pushViewController(viewController, animated: true)
					}
				)
				bottomSheetViewController.modalPresentationStyle = .overFullScreen
				self.present(bottomSheetViewController, animated: false)
			})
			.store(in: &cancellables)
	}

	private func setupSearchBarController() {
		navigationItem.title = "Daou Store"
		navigationItem.hidesSearchBarWhenScrolling = false
		navigationItem.largeTitleDisplayMode = .always
		navigationItem.backButtonTitle = ""
	}

	private func setup(_ product: Product) {
		if let url: URL = URL(string: product.imgUrl) {
			thumbnailImageView.setImage(source: .network(url))
		}
		brandLabel.text = product.brand
		contentLabel.text = product.content
		priceLabel.text = String(product.price)
	}
}
