//
//  CartTableViewCell.swift
//  ykb-order
//
//  Created by İhsan Akbay on 27.02.2023.
//

import UIKit

class CartTableViewCell: UITableViewCell {
	private lazy var productImageView: UIImageView = ImageViewFactory.build()
	
	private let titleLabel: UILabel = LabelFactory.build(
		font: Fonts.semibold(ofSize: 16))
	
	private let priceLabel: AmountView = {
		let view = AmountView(
			textAlignment: .left,
			amountLabelIdentifier: CustomIdentifiers.ListViewItem.priceLabel.rawValue)
		return view
	}()
	
	private let cartQuantityLabel: UILabel = LabelFactory.build(
		font: Fonts.semibold(ofSize: 20))
	
	private lazy var vStack: UIStackView = StackViewFactory.build(
		subviews: [priceLabel, titleLabel],
		axis: .vertical,
		spacing: 4,
		alignment: .leading,
		distribution: .fillProportionally)
	
	private lazy var hStack: UIStackView = StackViewFactory.build(
		subviews: [productImageView, vStack, cartQuantityLabel],
		axis: .horizontal,
		spacing: 10)
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupVC()
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setupVC() {
		addSubview(hStack)
		
		productImageView.snp.makeConstraints { make in
			make.width.equalTo(80)
			make.top.equalTo(hStack.snp.top)
			make.leading.equalTo(hStack.snp.leading)
			make.bottom.equalTo(hStack.snp.bottom)
		}
		
		hStack.snp.makeConstraints { make in
			make.leading.equalTo(16)
			make.top.equalTo(8)
			make.bottom.equalTo(-8)
			make.trailing.equalTo(-16)
		}
	}
	
	func setProduct(product: Product, cartQuantity: Int) {
		titleLabel.text = product.title
		priceLabel.configure(amount: product.price)
		
		if let imageUrl = product.images.first {
			productImageView.kf.setImage(
				with: URL(string: imageUrl),
				placeholder: UIImage(systemName: "questionmark.app.fill"))
		}

		cartQuantityLabel.text = cartQuantity.stringValue
	}
}
