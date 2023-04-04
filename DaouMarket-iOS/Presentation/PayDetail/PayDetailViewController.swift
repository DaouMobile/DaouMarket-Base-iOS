import UIKit
import Combine

final class PayDetailViewController: UIViewController {
	init(viewModel: PayDetailViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
		initViews()
		bind()
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private var cancellables: Set<AnyCancellable> = .init()
	private let viewModel: PayDetailViewModel

	private let deliveryInfoLabel: UILabel = {
		let label: UILabel = .init()
		label.set(
			text: "배송 정보",
			font: .systemFont(ofSize: 18, weight: .medium),
			textColor: .black
		)
		label.textAlignment = .left
		return label
	}()

	private let receiverTitleLabel: UILabel = {
		let label: UILabel = .init()
		label.set(
			text: "받는 사람",
			font: .systemFont(ofSize: 16, weight: .regular),
			textColor: .darkGray
		)
		label.textAlignment = .left
		return label
	}()

	private let receiverTextField: CustomTextField = .init()

	private let receiverPhoneNumberTitleLabel: UILabel = {
		let label: UILabel = .init()
		label.set(
			text: "연락처",
			font: .systemFont(ofSize: 16, weight: .regular),
			textColor: .darkGray
		)
		label.textAlignment = .left
		return label
	}()

	private let receiverPhoneNumberTextField: CustomTextField = .init()

	private let locationTitleLabel: UILabel = {
		let label: UILabel = .init()
		label.set(
			text: "배송지",
			font: .systemFont(ofSize: 16, weight: .regular),
			textColor: .darkGray
		)
		label.textAlignment = .left
		return label
	}()

	private let locationContentLabel: UILabel = {
		let label: UILabel = .init()
		label.set(
			text: "(16878) 경기도 용인시 수지구 디지털밸리로 81",
			font: .systemFont(ofSize: 16, weight: .regular),
			textColor: .black
		)
		label.textAlignment = .left
		return label
	}()

	private let requestLabel: UILabel = {
		let label: UILabel = .init()
		label.set(
			text: "요청 사항",
			font: .systemFont(ofSize: 16, weight: .regular),
			textColor: .darkGray
		)
		label.textAlignment = .left
		return label
	}()

	private let requestTextField: CustomTextField = .init(placeholder: "배송 시 요청사항을 입력해주세요.")

	private let ordererInfoLabel: UILabel = {
		let label: UILabel = .init()
		return label
	}()

	private let ordererNameLabel: UILabel = {
		let label: UILabel = .init()
		label.set(
			text: "주문자",
			font: .systemFont(ofSize: 16, weight: .regular),
			textColor: .darkGray
		)
		label.textAlignment = .left
		return label
	}()

	private let ordererNameTextField: CustomTextField = .init()

	private let ordererPhoneNumberLabel: UILabel = {
		let label: UILabel = .init()
		label.set(
			text: "연락처",
			font: .systemFont(ofSize: 16, weight: .regular),
			textColor: .darkGray
		)
		label.textAlignment = .left
		return label
	}()

	private let ordererPhoneNumberTextField: CustomTextField = .init()

	private func initViews() {
		view.addSubview(deliveryInfoLabel)
		deliveryInfoLabel.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
			make.horizontalEdges.equalToSuperview().inset(16)
		}

		view.addSubview(receiverTitleLabel)
		receiverTitleLabel.snp.makeConstraints { make in
			make.width.equalTo(42)
			make.top.equalTo(deliveryInfoLabel.snp.bottom).offset(16)
			make.leading.equalToSuperview().offset(16)
		}

		view.addSubview(receiverTextField)
		receiverTextField.snp.makeConstraints { make in
			make.centerY.equalTo(receiverTitleLabel.snp.centerY)
			make.leading.equalTo(receiverTitleLabel.snp.trailing).offset(16)
			make.trailing.equalToSuperview().offset(-16)
		}

		view.addSubview(receiverPhoneNumberTitleLabel)
		receiverPhoneNumberTitleLabel.snp.makeConstraints { make in
			make.width.equalTo(42)
			make.top.equalTo(receiverTitleLabel.snp.bottom).offset(16)
			make.leading.equalToSuperview().offset(16)
		}

		view.addSubview(receiverPhoneNumberTextField)
		receiverPhoneNumberTextField.snp.makeConstraints { make in
			make.centerY.equalTo(receiverPhoneNumberTitleLabel.snp.centerY)
			make.leading.equalTo(receiverPhoneNumberTitleLabel.snp.trailing).offset(16)
			make.trailing.equalToSuperview().offset(-16)
		}

		view.addSubview(locationTitleLabel)
		locationTitleLabel.snp.makeConstraints { make in
			make.width.equalTo(42)
			make.top.equalTo(receiverPhoneNumberTitleLabel.snp.bottom).offset(16)
			make.leading.equalToSuperview().offset(16)
		}

		view.addSubview(locationContentLabel)
		locationContentLabel.snp.makeConstraints { make in
			make.centerY.equalTo(locationTitleLabel.snp.centerY)
			make.leading.equalTo(locationTitleLabel.snp.trailing).offset(16)
			make.trailing.equalToSuperview().offset(-16)
		}

		view.addSubview(requestLabel)
		requestLabel.snp.makeConstraints { make in
			make.width.equalTo(42)
			make.top.equalTo(locationTitleLabel.snp.bottom).offset(16)
			make.leading.equalToSuperview().offset(16)
		}

		view.addSubview(requestTextField)
		requestTextField.snp.makeConstraints { make in
			make.centerY.equalTo(requestLabel.snp.centerY)
			make.leading.equalTo(requestLabel.snp.trailing).offset(16)
			make.trailing.equalToSuperview().offset(-16)
		}

		view.addSubview(ordererInfoLabel)
		ordererInfoLabel.snp.makeConstraints { make in
			make.top.equalTo(requestLabel.snp.bottom).offset(48)
			make.horizontalEdges.equalToSuperview().inset(16)
		}

		view.addSubview(ordererNameLabel)
		ordererNameLabel.snp.makeConstraints { make in
			make.width.equalTo(42)
			make.top.equalTo(ordererInfoLabel.snp.bottom).offset(16)
			make.leading.equalToSuperview().offset(16)
		}

		view.addSubview(ordererNameTextField)
		ordererNameTextField.snp.makeConstraints { make in
			make.centerY.equalTo(ordererNameLabel.snp.centerY)
			make.leading.equalTo(ordererNameLabel.snp.trailing).offset(16)
			make.trailing.equalToSuperview().offset(-16)
		}

		view.addSubview(ordererPhoneNumberLabel)
		ordererPhoneNumberLabel.snp.makeConstraints { make in
			make.width.equalTo(42)
			make.top.equalTo(ordererNameLabel.snp.bottom).offset(16)
			make.leading.equalToSuperview().offset(16)
		}

		view.addSubview(ordererPhoneNumberTextField)
		ordererPhoneNumberTextField.snp.makeConstraints { make in
			make.centerY.equalTo(ordererPhoneNumberLabel.snp.centerY)
			make.leading.equalTo(ordererPhoneNumberLabel.snp.trailing).offset(16)
			make.trailing.equalToSuperview().offset(-16)
		}
	}

	private func bind() {
		receiverTextField.textPublisher
			.compactMap({ $0 })
			.sink(receiveValue: viewModel.setReceiverName(_:))
			.store(in: &cancellables)

		receiverPhoneNumberTextField.textPublisher
			.compactMap({ $0 })
			.sink(receiveValue: viewModel.setReceiverPhoneNumber(_:))
			.store(in: &cancellables)

		ordererNameTextField.textPublisher
			.compactMap({ $0 })
			.sink(receiveValue: viewModel.setOrdererName(_:))
			.store(in: &cancellables)

		ordererPhoneNumberTextField.textPublisher
			.compactMap({ $0 })
			.sink(receiveValue: viewModel.setOrdererPhoneNumber(_:))
			.store(in: &cancellables)
	}

	private func setupSearchBarController() {
		navigationItem.title = "Daou Store"
		navigationItem.hidesSearchBarWhenScrolling = false
		navigationItem.largeTitleDisplayMode = .always
	}
}
