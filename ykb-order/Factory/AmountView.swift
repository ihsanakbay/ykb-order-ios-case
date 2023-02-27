//
//  AmountView.swift
//  ykb-order
//
//  Created by İhsan Akbay on 26.02.2023.
//

import SnapKit
import UIKit

class AmountView: UIView {
	private let textAlignment: NSTextAlignment
	private let amountLabelIdentifier: String
	
	private lazy var amountLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = textAlignment
		label.textColor = Colors.primary
		let text = NSMutableAttributedString(
			string: "$0",
			attributes: [
				.font: Fonts.bold(ofSize: 18)
			])
		text.addAttributes([
			.font: Fonts.bold(ofSize: 14)
		], range: NSMakeRange(0, 1))
		label.attributedText = text
		label.accessibilityIdentifier = amountLabelIdentifier
		return label
	}()
  
	init(textAlignment: NSTextAlignment, amountLabelIdentifier: String) {
		self.textAlignment = textAlignment
		self.amountLabelIdentifier = amountLabelIdentifier
		super.init(frame: .zero)
		layout()
	}
  
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
  
	func configure(amount: Double) {
		let text = NSMutableAttributedString(
			string: amount.currencyFormatted,
			attributes: [.font: Fonts.bold(ofSize: 18)])
		text.addAttributes(
			[.font: Fonts.bold(ofSize: 14)],
			range: NSMakeRange(0, 1))
		amountLabel.attributedText = text
	}
  
	private func layout() {
		addSubview(amountLabel)
		amountLabel.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}
}
