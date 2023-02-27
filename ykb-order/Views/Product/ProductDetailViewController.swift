//
//  ProductDetailViewController.swift
//  ykb-order
//
//  Created by İhsan Akbay on 27.02.2023.
//

import UIKit

class ProductDetailViewController: UIViewController {
	private lazy var productImageView: UIImageView = ImageViewFactory.build(
		contentMode: .scaleAspectFit,
		backgroundColor: .clear)

	private let titleLabel: UILabel = LabelFactory.build(
		font: Fonts.semibold(ofSize: 18),
		textAlignment: .left)

	private let priceLabel: AmountView = {
		let view = AmountView(
			textAlignment: .left,
			amountLabelIdentifier: CustomIdentifiers.ListViewItem.priceLabel.rawValue)
		return view
	}()

	private let quantityLabel: UILabel = LabelFactory.build(
		font: Fonts.bold(ofSize: 18),
		textAlignment: .left)

	private let unitLabel: UILabel = LabelFactory.build(
		text: "Pcs",
		font: Fonts.bold(ofSize: 18),
		textAlignment: .left)

	private lazy var stockStackView: UIStackView = StackViewFactory.build(
		subviews: [quantityLabel, unitLabel],
		axis: .horizontal,
		spacing: 4,
		alignment: .center,
		distribution: .fillProportionally)

	private lazy var hStackView: UIStackView = StackViewFactory.build(
		subviews: [priceLabel, stockStackView],
		axis: .horizontal,
		spacing: 4,
		alignment: .center)

	private var product: Product

	init(product: Product) {
		self.product = product
		super.init(nibName: nil, bundle: nil)
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		setupVC()
		configure()
	}

	@objc func addClicked() {}

	private func setupVC() {
		view.backgroundColor = .systemBackground
		[productImageView, titleLabel, hStackView].forEach(view.addSubview(_:))

		productImageView.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide)
			make.leading.equalTo(view.snp.leading)
			make.trailing.equalTo(view.snp.trailing)
			make.height.equalTo(SCREEN_SIZE.height * 0.3)
		}

		titleLabel.snp.makeConstraints { make in
			make.top.equalTo(productImageView.snp.bottom).offset(8)
			make.leading.equalTo(view.snp.leading).offset(8)
			make.trailing.equalTo(view.snp.trailing).offset(-8)
			make.height.equalTo(50)
		}

		hStackView.snp.makeConstraints { make in
			make.top.equalTo(titleLabel.snp.bottom).offset(8)
			make.leading.equalTo(view.snp.leading).offset(8)
			make.trailing.equalTo(view.snp.trailing).offset(-8)
			make.height.equalTo(50)
		}
	}

	private func configure() {
		if let imageUrl = product.images.first {
			productImageView.kf.setImage(with: URL(string: imageUrl), placeholder: UIImage(systemName: Icons.questionMark))
		}
		titleLabel.text = product.title
		quantityLabel.text = product.stock.stringValue
		priceLabel.configure(amount: product.price)
	}
}
