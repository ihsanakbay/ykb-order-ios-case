//
//  UIView+Extension.swift
//  ykb-order
//
//  Created by İhsan Akbay on 26.02.2023.
//

import UIKit

extension UIView {
	func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
		layer.cornerRadius = radius
		layer.masksToBounds = false
		layer.shadowOffset = offset
		layer.shadowColor = color.cgColor
		layer.shadowRadius = radius
		layer.shadowOpacity = opacity
		let backgroundCGColor = backgroundColor?.cgColor
		backgroundColor = nil
		layer.backgroundColor = backgroundCGColor
	}

	func addCornerRadius(radius: CGFloat) {
		layer.masksToBounds = false
		layer.cornerRadius = radius
	}
}
