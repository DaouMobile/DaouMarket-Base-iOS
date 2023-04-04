import UIKit
import Combine

final class ProductDetailBottomSheetViewController: UIViewController {
	init(name: String, price: Int ,completion: @escaping ((Int, Int) -> Void)) {
		pricePerProduct = price
		totalCount = .init(1)
		totalPrice = .init(price)
		self.completion = completion
		super.init(nibName: nil, bundle: nil)
		setup(name: name, price: price)
		initViews()
		bind()
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private let completion: ((Int, Int) -> Void)

	private var cancellables: Set<AnyCancellable> = .init()
	private let totalCount: CurrentValueSubject<Int, Never>
	private let totalPrice: CurrentValueSubject<Int, Never>
	private let pricePerProduct: Int

	private let backgroundView: UIView = {
		let view: UIView = .init()
		view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
		return view
	}()

	private let bottomSheetView: UIView = {
		let view: UIView = .init()
		view.backgroundColor = .white
		return view
	}()

	private let nameLabel: UILabel = {
		let label: UILabel = .init()
		label.set(
			font: .systemFont(ofSize: 14, weight: .regular),
			textColor: .black
		)
		label.textAlignment = .left
		return label
	}()

	private let productPriceLabel: UILabel = {
		let label: UILabel = .init()
		label.set(
			font: .systemFont(ofSize: 24, weight: .bold),
			textColor: .black
		)
		return label
	}()

	private lazy var totalStackView: UIStackView = {
		let stackView: UIStackView = .make(
			arrangedSubviews: [
				totalProductsCountLabel,
				SpacerView(axis: .horizontal),
				totalProductsPriceLabel
			],
			axis: .horizontal,
			alignment: .center,
			spacing: 0,
			distribution: .fill
		)
	}()

	private let totalProductsCountLabel: UILabel = {
		let label: UILabel = .init()
		label.set(
			font: .systemFont(ofSize: 15, weight: .regular),
			textColor: .black
		)
		return label
	}()

	private let totalProductsPriceLabel: UILabel = {
		let label: UILabel = .init()
		label.set(
			font: .systemFont(ofSize: 32, weight: .bold),
			textColor: .cyan
		)
		return label
	}()

	private lazy var buttonsStackView: UIStackView = {
		let stackView: UIStackView = .make(
			arrangedSubviews: [
				substractButton,
				productCountLabel,
				addButton
			],
			axis: .horizontal,
			alignment: .center,
			spacing: 1,
			distribution: .fill
		)
		return stackView
	}()

	private let productCountLabel: UILabel = {
		let label: UILabel = .init()
		label.set(
			text: "1",
			font: .systemFont(ofSize: 14, weight: .medium),
			textColor: .black
		)
		label.textAlignment = .center
		label.snp.makeConstraints { make in
			make.height.equalTo(32)
			make.width.equalTo(40)
		}
		label.roundCorners(8)
		label.setBorder(width: 1, color: .lightGray)
		return label
	}()

	private let addButton: UIButton = {
		let button: UIButton = .init()
		button.setTitle("+", for: .normal)
		button.setTitleColor(.black, for: .normal)
		button.roundCorners(8)
		button.snp.makeConstraints { make in
			make.size.equalTo(32)
		}
		button.setBorder(width: 1, color: .lightGray)
		return button
	}()

	private let substractButton: UIButton = {
		let button: UIButton = .init()
		button.setTitle("-", for: .normal)
		button.setTitleColor(.black, for: .normal)
		button.roundCorners(8)
		button.snp.makeConstraints { make in
			make.size.equalTo(32)
		}
		button.setBorder(width: 1, color: .lightGray)
		return button
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

	func setup(name: String, price: Int) {
		nameLabel.text = name
		productPriceLabel.text = "\(price) 원"
		totalProductsCountLabel.text = "총 수량 \(1) 개"
	}

	private func initViews() {
		view.addSubview(backgroundView)
		backgroundView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}

		view.addSubview(bottomSheetView)
		bottomSheetView.snp.makeConstraints { make in
			make.height.equalTo(280)
			make.bottom.equalToSuperview()
			make.horizontalEdges.equalToSuperview()
		}

		let dividerLineView: UIView = .init()
		dividerLineView.backgroundColor = .lightGray
		dividerLineView.snp.makeConstraints { make in
			make.height.equalTo(1)
		}

		[
			nameLabel,
			buttonsStackView,
			productPriceLabel,
			dividerLineView,
			totalProductsCountLabel,
			totalProductsPriceLabel,
			confirmButtonWidgetView
		].forEach({ bottomSheetView.addSubview($0) })

		nameLabel.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(16)
			make.horizontalEdges.equalToSuperview().inset(16)
		}
		buttonsStackView.snp.makeConstraints { make in
			make.top.equalTo(nameLabel.snp.bottom).offset(16)
			make.leading.equalToSuperview().offset(16)
		}

		productPriceLabel.snp.makeConstraints { make in
			make.centerY.equalTo(buttonsStackView.snp.centerY)
			make.trailing.equalToSuperview().offset(-16)
		}

		dividerLineView.snp.makeConstraints { make in
			make.top.equalTo(buttonsStackView.snp.bottom).offset(16)
			make.horizontalEdges.equalToSuperview().inset(16)
		}

		totalProductsCountLabel.snp.makeConstraints { make in
			make.top.equalTo(dividerLineView.snp.bottom).offset(16)
			make.leading.equalToSuperview().offset(16)
		}

		totalProductsPriceLabel.snp.makeConstraints { make in
			make.top.equalTo(dividerLineView.snp.bottom).offset(16)
			make.trailing.equalToSuperview().offset(-16)
		}

		confirmButtonWidgetView.snp.makeConstraints { make in
			make.height.equalTo(56)
			make.top.equalTo(totalProductsPriceLabel.snp.bottom).offset(16)
			make.horizontalEdges.equalToSuperview().inset(16)
			make.bottom.equalToSuperview().offset(-16)
		}
	}

	private func bind() {
		totalCount
			.sink(receiveValue: { [weak self] (count) in
				guard let self else { return }

				guard count <= 10 || count >= 1 else {
					print("잘못된 수량입니다. \(count) 개")
					return
				}

				self.productCountLabel.text = String(count)
				self.totalProductsCountLabel.text = "총 수량 \(count) 개"
				let newTotalPrice: Int = self.pricePerProduct * count
				self.totalPrice.send(newTotalPrice)
			})
			.store(in: &cancellables)

		totalPrice
			.sink(receiveValue: { [weak self] (price) in
				guard let self else { return }
				self.totalProductsPriceLabel.text = "\(price) 원"
			})
			.store(in: &cancellables)

		addButton.tapEventPublisher()
			.sink(receiveValue: { [weak self] _ in
				guard let self else { return }
				let newCount: Int = self.totalCount.value + 1
				guard newCount <= 10 else {
					print("최대 구매수량은 10개 입니다.")
					return
				}
				self.totalCount.send(newCount)
			})
			.store(in: &cancellables)

		substractButton.tapEventPublisher()
			.sink(receiveValue: { [weak self] _ in
				guard let self else { return }
				let newCount: Int = self.totalCount.value - 1
				guard newCount >= 1 else {
					print("최소 구매수량은 1개 입니다.")
					return
				}
				self.totalCount.send(newCount)
			})
			.store(in: &cancellables)

		backgroundView.tapEventPublisher()
			.sink(receiveValue: { [weak self] _ in
				self?.dismiss(animated: false)
			})
			.store(in: &cancellables)

		confirmButtonWidgetView.tapEventPublisher()
			.sink(receiveValue: { [weak self] _ in
				self?.dismiss(animated: false, completion: {
					guard let self else { return }
					self.completion(self.totalCount.value, self.totalPrice.value)
				})
			})
			.store(in: &cancellables)
	}
}
