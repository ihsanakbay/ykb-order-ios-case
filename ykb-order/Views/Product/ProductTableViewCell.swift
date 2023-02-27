//
//  ProductTableViewCell.swift
//  ykb-order
//
//  Created by İhsan Akbay on 26.02.2023.
//

import Combine
import Kingfisher
import SnapKit
import UIKit

enum ProductCellEvent {
	case quantityDidChange(value: Int)
}

class ProductTableViewCell: UITableViewCell {
	private let eventSubject = PassthroughSubject<ProductCellEvent, Never>()
	var eventPublisher: AnyPublisher<ProductCellEvent, Never> {
		eventSubject.eraseToAnyPublisher()
	}

	private let bgView: UIView = .init()

	private lazy var productImageView: UIImageView = ImageViewFactory.build()

	private let titleLabel: UILabel = LabelFactory.build(
		font: Fonts.semibold(ofSize: 16))

	private let priceLabel: AmountView = {
		let view = AmountView(
			textAlignment: .left,
			amountLabelIdentifier: CustomIdentifiers.ListViewItem.priceLabel.rawValue)
		return view
	}()

	private let quantityLabel: UILabel = LabelFactory.build(
		font: Fonts.regular(ofSize: 14),
		textAlignment: .left)

	private let unitLabel: UILabel = LabelFactory.build(
		text: "Pcs",
		font: Fonts.regular(ofSize: 14),
		textAlignment: .left)

	private lazy var stockStackView: UIStackView = StackViewFactory.build(
		subviews: [quantityLabel, unitLabel],
		axis: .horizontal,
		spacing: 4,
		distribution: .fillProportionally)

	private lazy var vStack: UIStackView = StackViewFactory.build(
		subviews: [priceLabel, titleLabel, stockStackView],
		axis: .vertical,
		spacing: 4,
		alignment: .leading,
		distribution: .fillProportionally)

	private let cartQuantityLabel: UILabel = LabelFactory.build(
		text: "0",
		font: Fonts.semibold(ofSize: 20))

	private lazy var stepper: UIStepper = {
		let stepper = UIStepper()
		stepper.value = 0
		stepper.maximumValue = 999
		stepper.minimumValue = 0
		stepper.addTarget(self, action: #selector(stepperDidChange(_:)), for: .valueChanged)
		stepper.isUserInteractionEnabled = true
		return stepper
	}()

	private let chevronIcon: UIImageView = {
		let iv = ImageViewFactory.build(
			contentMode: .scaleAspectFit,
			backgroundColor: .clear)
		iv.image = UIImage(systemName: Icons.chevronRight)
		iv.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
		return iv
	}()

	private lazy var stepperStack: UIStackView = StackViewFactory.build(
		subviews: [cartQuantityLabel, stepper],
		axis: .vertical,
		spacing: 4,
		alignment: .center,
		distribution: .fillProportionally)

	private lazy var hStack: UIStackView = StackViewFactory.build(
		subviews: [vStack, stepperStack, chevronIcon],
		axis: .horizontal,
		spacing: 4)

	var cancellables = Set<AnyCancellable>()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupVC()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func prepareForReuse() {
		super.prepareForReuse()
		cancellables = Set<AnyCancellable>()
	}

	private func setupVC() {
		[productImageView, hStack].forEach(bgView.addSubview(_:))
		addSubview(bgView)

		productImageView.snp.makeConstraints { make in
			make.width.equalTo(SCREEN_SIZE.width * 0.2)
			make.top.equalTo(bgView.snp.top)
			make.leading.equalTo(bgView.snp.leading)
			make.bottom.equalTo(bgView.snp.bottom)
		}
		
		vStack.snp.makeConstraints { make in
			make.width.equalTo(SCREEN_SIZE.width * 0.4)
		}

		hStack.snp.makeConstraints { make in
			make.top.equalTo(bgView.snp.top)
			make.leading.equalTo(productImageView.snp.trailing).offset(8)
			make.trailing.equalTo(bgView.snp.trailing)
			make.bottom.equalTo(bgView.snp.bottom)
		}

		bgView.snp.makeConstraints { make in
			make.top.equalTo(4)
			make.left.equalTo(8)
			make.bottom.equalTo(-4)
			make.right.equalTo(-8)
		}

		addShadow(offset: CGSize(width: 0, height: 3), color: .black, radius: 10, opacity: 0.1)
	}

	func setProduct(product: Product, cartQuantity: Int) {
		titleLabel.text = product.title
		priceLabel.configure(amount: product.price)
		quantityLabel.text = product.stock.stringValue
		
		if let imageUrl = product.images.first {
			productImageView.kf.setImage(
				with: URL(string: imageUrl),
				placeholder: UIImage(systemName: Icons.questionMark))
		}

		cartQuantityLabel.text = cartQuantity.stringValue
		stepper.value = cartQuantity.doubleValue
	}

	@objc func stepperDidChange(_ sender: UIStepper) {
		let value = Int(sender.value)
		eventSubject.send(.quantityDidChange(value: value))
		if let stockAmount = quantityLabel.text?.doubleValue {
			sender.maximumValue = stockAmount
		}
	}
}
