//
//  DataType+Extension.swift
//  ykb-order
//
//  Created by İhsan Akbay on 26.02.2023.
//

import Foundation

extension String {
	var doubleValue: Double? {
		Double(self)
	}
}

extension Int {
	var stringValue: String? {
		String(self)
	}

	var doubleValue: Double {
		Double(self)
	}
}

extension Double {
	var currencyFormatted: String {
		var isWholeNumber: Bool {
			isZero ? true : !isNormal ? false : self == rounded()
		}
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		formatter.minimumFractionDigits = isWholeNumber ? 0 : 2
		return formatter.string(for: self) ?? ""
	}
}
