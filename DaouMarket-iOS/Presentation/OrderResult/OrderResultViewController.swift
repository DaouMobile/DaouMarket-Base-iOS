import UIKit
import Combine

final class OrderResultViewController: UIViewController {
	init(orderResult: OrderResult) {
		super.init(nibName: nil, bundle: nil)
		orderCodeLabel.text = "주문번호: \(orderResult.code ?? "주문 번호 오류")"
		orderDetailLabel.text = "\(getFormatedDate(orderResult.paymentDate ?? "")) 결제금액:"
		orderPriceLabel.text = orderResult.totalPrice?.formatNumber()

		initViews()
		bind()
		setupNavigationBar()
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private var cancellables: Set<AnyCancellable> = .init()

	private let orderCompleteTitleLabel: UILabel = {
		let label: UILabel = .init()
		label.set(
			text: "결제가 완료되었습니다.",
			font: .systemFont(ofSize: 24, weight: .bold),
			textColor: .black
		)
		label.textAlignment = .center
		return label
	}()

	private let orderCodeLabel: UILabel = {
		let label: UILabel = .init()
		label.set(
			font: .systemFont(ofSize: 16, weight: .regular),
			textColor: .black
		)
		label.textAlignment = .center
		return label
	}()

	private lazy var orderDetailStackView: UIStackView = {
		let stackView: UIStackView = .make(
			arrangedSubviews: [
				orderDetailLabel,
				orderPriceLabel
			],
			axis: .horizontal,
			alignment: .center,
			spacing: 4,
			distribution: .fill
		)
		return stackView
	}()

	private let orderDetailLabel: UILabel = {
		let label: UILabel = .init()
		label.set(
			font: .systemFont(ofSize: 16, weight: .regular),
			textColor: .black
		)
		label.textAlignment = .center
		return label
	}()

	private let orderPriceLabel: UILabel = {
		let label: UILabel = .init()
		label.set(
			font: .systemFont(ofSize: 16, weight: .bold),
			textColor: .black
		)
		label.textAlignment = .center
		return label
	}()

	private let confirmButtonWidget: ButtonWidgetView = {
		let view: ButtonWidgetView = .init()
		view.roundCorners(16)
		view.backgroundColor = .black
		let titleLabel: UILabel = .init()
		titleLabel.set(
			text: "쇼핑 계속하기",
			font: .systemFont(ofSize: 20, weight: .bold),
			textColor: .white
		)
		view.setupViews([titleLabel])
		return view
	}()

	private func initViews() {
		view.backgroundColor = .white

		[
			orderCompleteTitleLabel,
			orderCodeLabel,
			orderDetailStackView,
			confirmButtonWidget
		].forEach({ view.addSubview($0) })

		orderCompleteTitleLabel.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide).offset(120)
			make.horizontalEdges.equalToSuperview()
		}

		orderCodeLabel.snp.makeConstraints { make in
			make.top.equalTo(orderCompleteTitleLabel.snp.bottom).offset(32)
			make.horizontalEdges.equalToSuperview()
		}

		orderDetailStackView.snp.makeConstraints { make in
			make.top.equalTo(orderCodeLabel.snp.bottom).offset(8)
			make.centerX.equalToSuperview()
		}

		confirmButtonWidget.snp.makeConstraints { make in
			make.height.equalTo(56)
			make.top.equalTo(orderDetailStackView.snp.bottom).offset(52)
			make.horizontalEdges.equalToSuperview().inset(16)
		}
	}

	private func bind() {
		confirmButtonWidget.tapEventPublisher()
			.sink(receiveValue: { [weak self] _ in
				self?.navigationController?.popToRootViewController(animated: true)
			})
			.store(in: &cancellables)
	}

	private func setupNavigationBar() {
		navigationItem.title = "Daou Store"
		navigationItem.hidesSearchBarWhenScrolling = false
		navigationItem.largeTitleDisplayMode = .never
		navigationItem.hidesBackButton = true
	}

	private func getFormatedDate(_ dateString: String) -> String {
		guard let date: Date = dateString.toDate() else {
			return ""
		}
		return date.formatted("yyyy년 MM월 dd일(E)")
	}
}


