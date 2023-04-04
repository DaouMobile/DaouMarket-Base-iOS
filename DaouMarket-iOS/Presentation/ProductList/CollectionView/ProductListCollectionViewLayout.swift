import UIKit

final class ProductListCollectionViewLayout: UICollectionViewFlowLayout {
	override func prepare() {
		super.prepare()
		guard let collectionView = collectionView else { return }
		sectionInset = .init(top: 0, left: 16, bottom: 0, right: 16)
		minimumLineSpacing = 24
		minimumInteritemSpacing = 0

		let availableWidth: CGFloat = collectionView.bounds.width - (sectionInset.left + sectionInset.right + minimumInteritemSpacing)
		let cellWidth: CGFloat = availableWidth
		let cellHeight: CGFloat = 96
		itemSize = CGSize(width: cellWidth, height: cellHeight)
	}
}
