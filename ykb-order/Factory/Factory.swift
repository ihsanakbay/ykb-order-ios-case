//
//  Factory.swift
//  ykb-order
//
//  Created by İhsan Akbay on 26.02.2023.
//

import SnapKit
import UIKit

// MARK: Button

struct ButtonFactory {
	static func build(
		text: String
	) -> UIButton {
		let button = UIButton()
		button.setTitle(text, for: .normal)
		button.titleLabel?.font = .systemFont(ofSize: 20)
		button.backgroundColor = Colors.primary
		button.layer.cornerRadius = 10
		return button
	}
}

// MARK: Label

enum LabelFactory {
	static func build(
		text: String? = nil,
		font: UIFont,
		backgroundColor: UIColor = .clear,
		textColor: UIColor = Colors.text,
		textAlignment: NSTextAlignment = .center
	) -> UILabel {
		let label = UILabel()
		label.text = text
		label.font = font
		label.backgroundColor = backgroundColor
		label.textColor = textColor
		label.textAlignment = textAlignment
		return label
	}
}

// MARK: Textfield

enum TextFieldFactory {
	static func build(
		placeholder: String,
		isSecure: Bool = false,
		backgroundColor: UIColor = Colors.translucent,
		textColor: UIColor = Colors.lightText,
		autoCorrection: UITextAutocorrectionType = .default,
		autoCapitalized: UITextAutocapitalizationType = .sentences
	) -> UITextField {
		let spacer = UIView()
		spacer.snp.makeConstraints { make in
			make.width.equalTo(12)
			make.height.equalTo(50)
		}

		let tf = UITextField()
		tf.leftView = spacer
		tf.leftViewMode = .always
		tf.textColor = textColor
		tf.backgroundColor = backgroundColor
		tf.isSecureTextEntry = isSecure
		tf.borderStyle = .none
		tf.layer.cornerRadius = 12
		tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])
		tf.autocorrectionType = autoCorrection
		tf.autocapitalizationType = autoCapitalized
		return tf
	}
}

// MARK: ImageView

enum ImageViewFactory {
	static func build(
		contentMode: UIView.ContentMode = .scaleAspectFill,
		backgroundColor: UIColor = .systemCyan,
		cornerRadius: CGFloat = 10
	) -> UIImageView {
		let imageView = UIImageView()
		imageView.contentMode = contentMode
		imageView.clipsToBounds = true
		imageView.backgroundColor = backgroundColor
		imageView.layer.cornerRadius = cornerRadius
		return imageView
	}
}

// MARK: StackView

enum StackViewFactory {
	static func build(
		subviews: [UIView],
		axis: NSLayoutConstraint.Axis,
		spacing: CGFloat,
		alignment: UIStackView.Alignment = .fill,
		distribution: UIStackView.Distribution = .fill
	) -> UIStackView {
		let stackView = UIStackView(arrangedSubviews: subviews)
		stackView.axis = axis
		stackView.spacing = spacing
		stackView.alignment = alignment
		stackView.distribution = distribution
		return stackView
	}
}
