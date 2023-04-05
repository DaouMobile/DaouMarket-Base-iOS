import UIKit
import Kingfisher

final class ProductListCollectionViewCell: UICollectionViewCell {
	static let reuseIdentifier: String = "ProductListCollectionViewCell"

	override init(frame: CGRect) {
		super.init(frame: frame)

		initView()
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private let thumbnailImageView: UIImageView = {
		let imageView: UIImageView = .init(image: .init(named: "noImage"))
		imageView.contentMode = .scaleAspectFit
		imageView.roundCorners(16)
		return imageView
	}()

	private lazy var textStackView: UIStackView = {
		let stackView: UIStackView = .make(
			arrangedSubviews: [
				brandLabel,
				contentLabel,
				SpacerView(axis: .vertical),
				priceLabel
			],
			axis: .vertical,
			alignment: .fill,
			spacing: 2,
			distribution: .fill
		)
		return stackView
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
		label.numberOfLines = 2
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

	func setup(_ viewData: Product) {
		if let url: URL = URL(string: viewData.imgUrl) {
			thumbnailImageView.setImage(source: .network(url))
		}
		brandLabel.text = viewData.brand
		contentLabel.text = viewData.content
		priceLabel.text = viewData.price.formatNumber()
	}

	private func initView() {
		backgroundColor = .white

		contentView.addSubview(thumbnailImageView)
		thumbnailImageView.snp.makeConstraints { make in
			make.size.equalTo(88)
			make.centerY.equalToSuperview()
			make.leading.equalToSuperview()
		}

		contentView.addSubview(textStackView)
		textStackView.snp.makeConstraints { make in
			make.leading.equalTo(thumbnailImageView.snp.trailing).offset(24)
			make.verticalEdges.equalToSuperview()
			make.trailing.equalToSuperview()
		}
	}
}
