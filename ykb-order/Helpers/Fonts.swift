//
//  Fonts.swift
//  ykb-order
//
//  Created by İhsan Akbay on 26.02.2023.
//

import UIKit

struct Fonts {
	static func regular(ofSize size: CGFloat) -> UIFont {
		return .systemFont(ofSize: size, weight: .regular)
	}

	static func bold(ofSize size: CGFloat) -> UIFont {
		return .systemFont(ofSize: size, weight: .bold)
	}

	static func semibold(ofSize size: CGFloat) -> UIFont {
		return .systemFont(ofSize: size, weight: .semibold)
	}
}
